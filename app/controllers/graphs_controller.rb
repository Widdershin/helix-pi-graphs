class GraphsController < ApplicationController
  def index

    @commit_benchmarks = CommitBenchmark.includes(:commit).in_commit_order
  end
end
