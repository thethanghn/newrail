class RelationshipsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    response_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    @user = User.find(params[:relationship][:followed_id])
    current_user.unfollow!(@user)
    response_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
end