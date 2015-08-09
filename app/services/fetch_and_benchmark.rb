class FetchAndBenchmark
  def call
    FetchCommits.new.call

    Commit.unbenchmarked.each do |commit|
      BenchmarkCommit.new(commit).call
    end
  end
end

