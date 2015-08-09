class CommitBenchmarksController < ApplicationController
  def index
    render json: Hash[CommitBenchmark.successful.map do |b|
      [b.commit.committed_at, b.data["results"]]
    end]
  end
end
