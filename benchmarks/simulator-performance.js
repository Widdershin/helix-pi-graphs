const simulateWorld = require('../helix-pi/app/simulator');
const Entity = require('../helix-pi/app/entity');
const _ = require('lodash');

const individual = [
  (entity, api, currentFrame) => {
    api.setVelocity(entity, {x: 3, y: 0});
  }
];

const entity = new Entity(individual, {x: 0, y: 0}, [], true);

const entities = [entity];

const RUNS = 1000;
const FRAMES = 10;

function time (f) {
  const startTime = Date.now();

  f();

  const finishTime = Date.now();

  return finishTime - startTime;
}

function testSimulator () {
  simulateWorld(entities, FRAMES, []);
}

function runBenchmark () {
  return time(testSimulator);
}

function mean (numbers) {
  return _.sum(numbers) / numbers.length;
};

const runTimes = _.chain(RUNS).range().map(runBenchmark).value();

console.log(JSON.stringify({results: mean(runTimes)}));

