class Contact < ActiveRecord::Base
  # Cpmtact form validations
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
end