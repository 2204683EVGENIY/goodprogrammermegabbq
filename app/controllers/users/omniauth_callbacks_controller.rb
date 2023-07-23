class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    omniauth_callbacks("Github")
  end

  def vkontakte
    omniauth_callbacks("Vkontakte")
  end

  private

  def omniauth_callbacks(provider)
    @user = User.find_for_oauth(request.env["omniauth.auth"], provider)

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)

      sign_in_and_redirect @user, event: :require_no_authentication
    else
      flash[:error] = I18n.t("devise.omniauth_callbacks.failure", kind: provider, reason: "authentication error")

      redirect_to new_user_registration_path
    end
  end
end
