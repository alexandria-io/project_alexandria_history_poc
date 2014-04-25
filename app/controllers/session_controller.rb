class SessionController < ApplicationController
  def create
    @success = 'SUCCESS!'
  end

  def failure
    @failure = params
  end
end
