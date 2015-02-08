class UserMailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  layout 'mail/action'

  def welcome_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: 'Welcome to Tips on Rails'
    )
  end
end
