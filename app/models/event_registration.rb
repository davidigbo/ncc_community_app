class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, inclusion: { in: %w[pending confirmed cancelled] }
end
