class GithubWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :push

  def push
    FetchAndBenchmark.delay.run

    render text: 'Yay!'
  end
end
