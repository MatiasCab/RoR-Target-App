class CreateUserService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def sign_up_info
    plan = Plan.find_by(name: 'Basic')
    user_dup_params = resource_params.dup
    user_dup_params[:plan_id] = plan.id
    user_dup_params
  end

  private

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :username, :first_name, :last_name)
  end
end
