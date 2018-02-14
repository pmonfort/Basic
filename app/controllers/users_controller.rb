class UsersController < ApplicationController
  before_action :authorize, only: [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    descending = -1
    @skills = @user.skills.includes(:endorsements).sort_by do |s|
      s.endorsements_count_by_user(@user.id) * descending
    end
  end

  def new; end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
