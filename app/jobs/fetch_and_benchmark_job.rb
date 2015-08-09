class FetchAndBenchmarkJob < ActiveJob::Base
  queue_as :default

  def perform
    FetchAndBenchmark.new.call
  end
end
