class SkillsController < ApplicationController
  before_action :authorize

  def show
    @skill = Skill.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    if user.add_endorsement(skill_params[:name], current_user.id)
      flash[:success] = 'Skill suggested.'
    else
      flash[:warning] = 'Something went wrong, please try later.'
    end
    redirect_to user_path(user)
  end

  private

  def skill_params
    params.require(:skill).permit(:name)
  end
end
