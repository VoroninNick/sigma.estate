class Banner < ActiveRecord::Base
  attr_accessible *attribute_names
  has_many :apartment_banners
  has_many :complex_banners

  attr_accessible :apartment_banners
  accepts_nested_attributes_for :apartment_banners, :allow_destroy => true
  attr_accessible :apartment_banners_attributes

  attr_accessible :complex_banners
  accepts_nested_attributes_for :complex_banners, :allow_destroy => true
  attr_accessible :complex_banners_attributes

  rails_admin do
    label 'Банери'
    label_plural 'Банери'

    edit do

      field :apartment_banners do
        label 'Банер на сторінку квартир'
      end
      field :complex_banners do
        label 'Банер на сторінку комплекси'
      end
    end
  end
end
