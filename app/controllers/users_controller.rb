class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    if is_his_profile?(params['id'])
      @user = User.where(id: params['id'])[0]
    else
      flash[:error] = "Vous n'avez pas l'autorisation d'effectuer cette action"
      redirect_to root_path
    end
  end

  private

  def is_his_profile?(id)
    return true if id.to_i == current_user.id.to_i
  end
end
