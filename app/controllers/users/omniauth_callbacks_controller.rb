class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.new_record?
      @user.save!
      sign_in @user
      redirect_to welcome_user_path(@user)
    elsif @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    else
      # Not entirely sure when this scenario is applicable.
      # If the sign in fails this method will not get called so
      # there should be always a new user created or signed in
      session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
