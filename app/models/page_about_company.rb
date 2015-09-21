class PageAboutCompany < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :our_partnerses, class_name: OurPartners, :foreign_key => :page_about_companies_id
  has_many :our_teams, :foreign_key => :page_about_companies_id

  attr_accessible :our_partnerses
  accepts_nested_attributes_for :our_partnerses, :allow_destroy => true
  attr_accessible :our_partnerses_attributes

  attr_accessible :our_teams
  accepts_nested_attributes_for :our_teams, :allow_destroy => true
  attr_accessible :our_teams_attributes

  rails_admin do
    label 'Сторінка - Про нас'
    label_plural 'Сторінка - Про нас'

    edit do
      field :our_teams do
        label 'наша команда'
      end
      field :our_partnerses do
        label 'наші партнери'
      end
    end
  end
end
