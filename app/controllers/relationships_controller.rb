class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_following_user, only: :destroy

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def load_user
    @user = User.find_by(id: params[:followed_id])
    unless @user
      redirect_to @user
      flash[:danger] = t "fail_follow"
    end
  end

  def load_following_user
    @user = Relationship.find_by(id: params[:id])
    unless @user
      redirect_to @user
      flash[:danger] = t "fail_unfollow"
    end
    @user = @user.followed
  end
end
