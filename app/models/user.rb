class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

         has_one :profile, dependent: :destroy
         has_many :business_profiles, dependent: :destroy
         has_many :events, dependent: :destroy
         has_many :feedbacks, dependent: :destroy
         has_many :replies, dependent: :destroy
         has_one_attached :avatar

         enum :role, { general_user: 0, agent: 1, distributor: 2, investor: 3, admin: 4 }

         validates :name, presence: true
         validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
         validates :password, confirmation: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
        #  validates :role, presence: true


          acts_as_votable
          # act_as_taggable_on :interests, :badges
          # acts_as_taggable_on :interests

        #  has_many :posts, dependent: :destroy
        #  has_many :comments, dependent: :destroy
        #  has_many :votes, dependent: :destroy
        #  has_many :voted_posts, through: :votes, source: :votable, source_type: 'Post'
        #  has_many :voted_comments, through: :votes, source: :votable, source_type: 'Comment'
        #  has_many :notifications, dependent: :destroy

        after_create :create_profile_for_user

        # def self.from_omniauth(auth)
        #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        #     user.email = auth.info.email
        #     user.password = Devise.friendly_token[0, 20]
        #     user.buiid_profile.save
        #   end
        # end

        private
        
        def create_profile_for_user
          Profile.create(user: self) unless profile.present?
        end

end
