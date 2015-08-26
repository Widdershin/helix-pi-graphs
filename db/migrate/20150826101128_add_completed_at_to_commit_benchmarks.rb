class AddCompletedAtToCommitBenchmarks < ActiveRecord::Migration
  def change
    add_column :commit_benchmarks, :completed_at, :datetime
  end
end
