class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:show, :index]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    if @user.nil?
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "message.success.create_user"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "userLink.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
