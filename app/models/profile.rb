class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  acts_as_votable

  acts_as_taggable_on :interests
end
