class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show] #[:index, :edit, :update, :destroy]
  before_action :load_users_by_id, except: [:new, :index, :create] #[:show, :update, :edit, :correct_user, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.activated_users.paginate(page: params[:page], per_page: Settings.users_per_page)
  end

  def show
    redirect_to root_url and return unless @user.activated
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @user.destroy ? flash[:success] = t("deleted") : flash[:danger] = t("fail_delete")
    redirect_to users_url
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_users_by_id
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "user_not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end
end
