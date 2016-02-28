class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @homepage = houses_url
    @newhouse = new_house_url
    mail(to: @user.email, subject: "Welcome to rmmts!")
  end

end
