class SkillsController < ApplicationController
  before_action :authorize

  def destroy
    skill = Skill.find(params[:id])
    if skill.destroy
      flash[:success] = 'Skill deleted.'
    else
      flash[:warning] = 'Something went wrong, please try later.'
    end
    redirect_to user_path(current_user)
  end
end
