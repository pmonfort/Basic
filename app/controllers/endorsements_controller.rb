class EndorsementsController < ApplicationController
  before_action :authorize

  def create
    if user.add_endorsement(endorsement_params[:skill_name], current_user.id)
      flash[:success] = 'Skill suggested.'
    else
      flash[:warning] = 'Something went wrong, please try later.'
    end
    redirect_to user_path(user)
  end

  def destroy
    if user.remove_endorsement(endorsement_params[:skill_name], current_user.id)
      flash[:success] = 'Endorsement removed.'
    else
      flash[:warning] = 'Something went wrong, please try later.'
    end
    redirect_to user_path(user)
  end

  private

  def user
    @user ||= User.find(endorsement_params[:endorsed_user_id])
  end

  def endorsement_params
    params.permit(:skill_name, :endorsed_user_id)
  end
end
