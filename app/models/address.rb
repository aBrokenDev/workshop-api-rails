class Address < ApplicationRecord
  belongs_to :person

  validates :person, :postal_code, :state, :city, :neighborhood, :street, :number, presence: true
end
