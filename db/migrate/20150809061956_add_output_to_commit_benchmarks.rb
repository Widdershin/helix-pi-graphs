class AddOutputToCommitBenchmarks < ActiveRecord::Migration
  def change
    add_column :commit_benchmarks, :output, :text
  end
end
