class Reply < ApplicationRecord
  belongs_to :feedback
  belongs_to :user

  validates :content, presence: true, length: { maximum: 500 }
end
