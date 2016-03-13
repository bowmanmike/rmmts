class MateMailer < ApplicationMailer

  def welcome_email(mate)
    @mate = mate
    @homepage = houses_url
    @newhouse = new_house_url
    mail(to: @mate.email, subject: "Welcome to Chortal!")
  end

  def join_house(mate, house)
    @mate = mate
    @house = house
    mail(to: @mate.email, subject: "You've joined a house!")
  end

  def chore_notification(chore, mate)
    @mate = mate
    @chore = chore
    mail(to: @mate.email, subject: "Reminder for #{@chore.name}")
  end

  def chore_due(chore, mate)
    @chore = chore
    @mate = mate
    mail(to: @mate.email, subject: "#{@chore.name} is due today")
  end

  def expense_reminder(expense, mate)
    @expense = expense
    @mate = mate
    mail(to: @mate.email, subject: "Reminder for #{@expense.name}")
  end

  def expense_due(expense, mate)
    @expense = expense
    @mate = mate
    mail(to: @mate.email, subject: "Payment for #{@expense.name} is due")
  end

  def reset_password_email(mate)
    @mate = mate
    @url = edit_password_reset_url(@mate.reset_password_token)
    mail(to: @mate.email, subject: "Reset Password")
  end

end
