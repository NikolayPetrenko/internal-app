class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :set_correct_layout

  private
    def set_correct_layout
      user_signed_in? ? "application" : "loggedout"
    end
end
