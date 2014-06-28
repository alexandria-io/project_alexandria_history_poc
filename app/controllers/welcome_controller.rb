class WelcomeController < ApplicationController

  def index

    @archives = Archive.all

    respond_to do |format|

      format.html # index.html.erb

    end
  end

  def about
  end
end
