class AddBenchmarkToCommitBenchmarks < ActiveRecord::Migration
  def change
    add_column :commit_benchmarks, :benchmark, :string
  end
end
