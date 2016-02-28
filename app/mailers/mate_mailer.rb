class MateMailer < ApplicationMailer

  def welcome_email(mate)
    @mate = mate
    @homepage = houses_url
    @newhouse = new_house_url
    mail(to: @mate.email, subject: "Welcome to rmmts!")
  end

end
