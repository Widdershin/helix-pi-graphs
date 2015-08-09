class BenchmarkCommit
  def initialize(commit)
    @commit = commit
  end

  def call
    repo.setup
    repo.checkout(@commit.sha)

    results = `babel-node benchmark.js`

    @commit.commit_benchmarks.create!(:data => JSON.parse(results))
  end

  def repo
    @repo ||= HelixPiRepo.new
  end
end

