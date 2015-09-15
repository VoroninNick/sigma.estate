class ContactMailer < ApplicationMailer


  def have_questions(name, phone, email, message)
    @name = name
    @phone = phone
    @email = email
    @message = message

    mail(from: email, subject: 'Виникли питання', to: SupportEmail.first.have_questions)
  end
end
