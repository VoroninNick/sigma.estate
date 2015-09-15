class SupportEmail < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    label 'Технічна електронна скринька'
    label_plural 'Технічни електронни скриньки'

    edit do
      field :have_questions do
        label 'виникли питання:'
        help ''
      end
      field :call_to_order do
        label 'замовити дзвінок:'
      end
      field :book_review do
        label 'замовити огляд:'
        help ''
      end
    end
  end
end
