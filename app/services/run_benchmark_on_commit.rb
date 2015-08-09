require 'open3'

class RunBenchmarkOnCommit < Struct.new(:benchmark, :commit)
  def call
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

      commit.commit_benchmarks.create!(
        :benchmark => benchmark,
        :output => output,
        :success => success,
        :data => data
      )
    end
  end

  private

  def repo
    @repo ||= HelixPiRepo.new
  end
end

