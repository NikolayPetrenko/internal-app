class UsersController < ApplicationController
  def search
    @users = User.search params[:query]

    respond_to do |format|
      format.json { render :json => @users }
    end
  end
end
