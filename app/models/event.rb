class Event < ApplicationRecord
    has_many :event_registrations, dependent: :destroy
    has_many :users, through: :event_registrations
    has_many :feedbacks, dependent: :destroy

    has_one_attached :image
    # has_rich_text :description

    enum :status, { upcoming: 0, ongoing: 1, completed: 2, cancelled: 3 }

    validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 1000 }
    # validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
end
