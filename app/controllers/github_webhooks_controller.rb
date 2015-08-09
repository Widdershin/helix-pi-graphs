class GithubWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :push

  def push
    render text: 'It worked :)'
  end
end
