class FetchAndBenchmark
  def self.run
    new.call
  end

  def call
    FetchCommits.new.call

    Commit.all.each do |commit|
      benchmarks_to_perform = benchmarks - commit.commit_benchmarks.pluck(:benchmark)

      benchmarks_to_perform.each do |benchmark|
        RunBenchmarkOnCommit.new(benchmark, commit).call
      end
    end
  end

  private

  def benchmarks
    GetBenchmarks.new.call
  end
end

