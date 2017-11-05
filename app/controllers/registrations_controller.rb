class RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:fullname, :phone_number, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:fullname, :phone_number, :email, :password, :password_confirmation, :current_password)
  end
	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end
end
