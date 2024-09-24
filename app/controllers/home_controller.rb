class HomeController < ApplicationController
  before_action :redirect_logged_in_user, only: :index
  def index
  end

  private

  def redirect_logged_in_user
    if user_signed_in?
      redirect_to edit_user_registration_path # TODO: Change after creating main tweets route
    end
  end
end
