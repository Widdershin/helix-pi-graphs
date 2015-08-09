class Commit < ActiveRecord::Base
  has_many :commit_benchmarks

  scope :unbenchmarked, -> {
    includes(:commit_benchmarks)
      .where(:commit_benchmarks => {:commit_id => nil})
  }
end
