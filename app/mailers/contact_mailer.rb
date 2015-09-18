class ContactMailer < ApplicationMailer
  default from: "support Sigma Estate <sigma@pr-group.in>"

  def have_questions(name, phone, email, message)
    @name = name
    @phone = phone
    @email = email
    @message = message

    mail(:template_path => 'contact_mailer', :template_name => 'have_questions', layout: false, subject: 'Виникли питання...', to: SupportEmail.first.have_questions.split(','))
  end

  def call_to_order(user_name, phone_number)
    @user_name = user_name
    @phone_number = phone_number

    mail(:template_path => 'contact_mailer', :template_name => 'call_to_order', :layout => false, :subject => 'Замовити дзвінок...', :to => SupportEmail.first.call_to_order.split(','))
  end
end
