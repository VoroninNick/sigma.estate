class McsubscribeController < ApplicationController

  def index
  end

  def subscribe

    email = params[:email][:address]

    if !email.blank?

      begin

        @mc.lists.subscribe(@list_id, {'email' => email})

        respond_to do |format|
          format.json{render :json => {:message => "Успішно! Перевірте вашу електронну пошту, щоб підтвердити реєстрацію."}}
        end

        rescue Mailchimp::ListAlreadySubscribedError

          respond_to do |format|
            format.json{render :json => {:message => "#{email} вже підписаний на розсилку"}}
          end

        rescue Mailchimp::ListDoesNotExistError

          respond_to do |format|
            format.json{render :json => {:message => "Не може знайти списку."}}
          end

        rescue Mailchimp::Error => ex

            if ex.message

              respond_to do |format|
                format.json{render :json => {:message => "Помилка. Будь ласка, введіть дійсну електронну пошту."}}
              end

            else

              respond_to do |format|
                format.json{render :json => {:message => "Виникла невідома помилка."}}
              end
            end

        end

        else

          respond_to do |format|
            format.json{render :json => {:message => "E-mail адрес не може бути порожнім. Будь ласка, введіть дійсний ідентифікатор електронної пошти."}}
          end

        end
  end
end
