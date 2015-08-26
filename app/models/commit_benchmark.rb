class CommitBenchmark < ActiveRecord::Base
  belongs_to :commit

  scope :completed, -> { where.not(completed_at: nil) }
  scope :successful, -> { where(success: true) }
  scope :in_commit_order, -> { joins(:commit).order('commits.committed_at ASC') }

  def pending?
    completed_at.nil?
  end
end
