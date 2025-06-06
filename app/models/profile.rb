class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  validates :bio, length: { maximum: 500 }, allow_blank: true
  
end
