class BenchmarkCommit
  def initialize(commit)
    @commit = commit
    @repo = HelixPiRepo.new
  end

  def call
    repo.checkout(commit.hash)
  end
end

