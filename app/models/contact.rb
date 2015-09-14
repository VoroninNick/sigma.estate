class Contact < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    label 'Контактні дані'
    label_plural 'Контактні дані'

    edit do
      group :address do
        label "Адрес"
        # active false
        field :country do
          label 'країна та індекс:'
          help ''
        end
        field :city do
          label 'місто:'
        end
        field :address do
          label 'адрес:'
          help ''
        end
      end

      field :m_phone do
        label 'основний номер телефону:'
      end
      field :s_phone do
        label 'додатковий номер телефону:'
      end
      field :t_phone do
        label 'додатковий номер телефону:'
      end


      field :m_email do
        label 'основна електронна скринька:'
      end
      field :s_email do
        label 'додаткова електронна скринька:'
      end

      field :map do
        label 'координати для Google map:'
        help ''
      end
      field :timetable do
        label 'робочий графік:'
      end

      group :social do
        label "Соціальні мережі"
        active false
        field :facebook do
          label 'facebook:'
        end
        field :google do
          label 'google plus:'
        end
        field :twitter do
          label 'twitter:'
        end
        field :instagram do
          label 'instagram:'
        end
        field :youtube do
          label 'youtube:'
        end
      end

    end
  end
end
