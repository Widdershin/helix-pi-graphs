class AddSuccessToCommitBenchmarks < ActiveRecord::Migration
  def change
    add_column :commit_benchmarks, :success, :boolean
  end
end
