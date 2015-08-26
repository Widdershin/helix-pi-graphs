require 'open3'

class RunBenchmarkOnCommit < Struct.new(:benchmark, :commit)
  def call
    commit_benchmark = commit.commit_benchmarks.create!(
      :benchmark => benchmark
    )

    repo.setup
    repo.checkout(commit.sha)

    Open3.popen2e('babel-node', benchmark) do |stdin, stdout_err, result|
      output_lines = []

      while line = stdout_err.gets
        output_lines << line
      end

      success = result.value.success?
      output = output_lines.join("\n")

      data = if success
        JSON.parse(output)
      else
        nil
      end

      commit_benchmark.update!(
        :data => data,
        :output => output,
        :success => success,
        :completed_at => Time.now
      )
    end
  end

  private

  def repo
    @repo ||= HelixPiRepo.new
  end
end

