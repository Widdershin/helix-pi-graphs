class CommitBenchmark < ActiveRecord::Base
  belongs_to :commit

  scope :in_commit_order, -> { joins(:commit).order('commits.committed_at ASC') }
end
