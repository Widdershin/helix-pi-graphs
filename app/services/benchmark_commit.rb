require 'open3'

class BenchmarkCommit
  def initialize(commit)
    @commit = commit
  end

  def call
    repo.setup
    repo.checkout(@commit.sha)

    Open3.popen2e('babel-node benchmark.js') do |stdin, stdout_err, result|
      success = result.value.success?

      output = stdout_err.read

      data = if success
        JSON.parse(output)
      else
        nil
      end

      @commit.commit_benchmarks.create!(
        :output => output,
        :success => success,
        :data => data
      )
    end
  end

  def repo
    @repo ||= HelixPiRepo.new
  end
end

