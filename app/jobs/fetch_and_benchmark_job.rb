class FetchAndBenchmarkJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    FetchAndBenchmark.new.call
  end
end
