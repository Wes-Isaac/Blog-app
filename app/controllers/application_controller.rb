class ApplicationController < ActionController::Base
  def current_user
    User.limt(1)
  end
end
