class PersonMailer < ActionMailer::Base

  def welcome_email(person)
    @person = person
    mail(:to => @person.email, :subject => "Registered", :from => "example@gmail.com")
  end
end
