class GraphsController < ApplicationController
  def index
    @commit_benchmarks =
      CommitBenchmark.includes(:commit).completed.in_commit_order
  end
end
