class UserMailer < ActionMailer::Base
  default from: 'do-not-reply@tibiasmuggler.com'

  def signup_completed_email(user)
    @user = user
    mail(to: user.email, subject: 'TibiaSmuggler.com - You have created an account!')
  end
end
