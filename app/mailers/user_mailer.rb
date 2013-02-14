class UserMailer < ActionMailer::Base
  default from: "tetrispals.automail@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "https://tetrispals.heroku.com/signin"
    mail(:to => user.email, :subject => "Welcome to Tertis Pals")
  end

end
