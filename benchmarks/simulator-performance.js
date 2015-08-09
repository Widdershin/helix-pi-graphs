const simulateWorld = require('../helix-pi/app/simulator');
const Entity = require('../helix-pi/app/entity');
const _ = require('lodash');

const individual = [
  (entity, api, currentFrame) => {
    api.setVelocity(entity, {x: 3, y: 0});
  }
]

const individuals = [individual];

const entity = new Entity(individual, {x: 0, y: 0}, [], true);


const RUNS = 1000;
const FRAMES = 10;

function time(f) {
  const startTime = Date.now();

  f();

  const finishTime = Date.now();

  return finishTime - startTime;
}

function testSimulator () {
  simulateWorld(individuals, FRAMES, []);
}

function runBenchmark () {
  return time(testSimulator);
}
const runTimes = _.chain(RUNS).range().map(runBenchmark).value();

function mean (numbers) {
  return _.sum(numbers) / numbers.length;
}

console.log(JSON.stringify({results: mean(Array.from(runTimes))}));

