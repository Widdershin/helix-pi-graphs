class CreateCommitBenchmarks < ActiveRecord::Migration
  def change
    create_table :commit_benchmarks do |t|
      t.integer :commit_id
      t.json :data

      t.timestamps null: false
    end
  end
end
