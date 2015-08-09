class GithubWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :push

  def push
    FetchAndBenchmarkJob.perform_later

    render text: 'Yay!'
  end
end
