class GithubWebhooksController < ApplicationController
  protect_from_forgery except: :push

  def push
    render status: 200
  end
end
