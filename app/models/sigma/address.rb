class Sigma::Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
end