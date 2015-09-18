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

  def book_review(user_name, phone_number, date, time_from, time_to, message)
    @user_name = user_name
    @phone_number = phone_number
    @date = date
    @time_from = time_from
    @time_to = time_to
    @message = message

    mail(:template_path => 'contact_mailer', :template_name => 'book_review', :layout => false, :subject => 'Замовити огляд...', :to => SupportEmail.first.book_review.split(','))
  end
end
