class CommitBenchmarksController < ApplicationController
  def index
    CommitBenchmark.all.to_json
  end
end
