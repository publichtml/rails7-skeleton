class WelcomeController < ApplicationController
  def index
    render plain: "Welcome\n"
  end
end
