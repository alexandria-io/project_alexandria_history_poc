class SessionsController < ApplicationController
  def create
    puts request.env['omniauth.auth']
    puts env["omniauth.params"]
    @success = 'SUCCESS!'
  end

  def failure
    @failure = params
  end
end
