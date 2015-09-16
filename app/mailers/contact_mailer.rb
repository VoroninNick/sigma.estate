class ContactMailer < ApplicationMailer


  def have_questions(name, phone, email, message)
    @name = name
    @phone = phone
    @email = email
    @message = message

    mail(:template_path => 'contact_mailer', :template_name => 'have_questions', layout: false,from: email, subject: 'Виникли питання', to: SupportEmail.first.have_questions)
  end
end
