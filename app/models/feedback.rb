class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :event
  
  enum status: { pending: 0, resolved: 1, closed: 2 }

  validates :content, presence: true, length: { maximum: 1000 }
end
