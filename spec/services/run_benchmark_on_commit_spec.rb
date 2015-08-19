require 'rails_helper'

describe RunBenchmarkOnCommit do
  it 'runs a benchmark against a commit and saves the result' do
    commit = Commit.create!(sha: '90e4cdf')

    service = RunBenchmarkOnCommit.new(
      './node_modules/helix-pi-benchmarks/benchmarks/simulator-performance.js',
      commit
    )

    service.call

    bench = commit.commit_benchmarks.last

    expect(bench).to be_success, bench.output

    expect(bench.data["results"]).to be_a(Float), bench.data
  end
end
