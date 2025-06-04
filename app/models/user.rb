class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

         has_one :profile, dependent: :destroy
         has_one_attached :avatar

         enum role: { general_user: 0, agent:1, admin: 2 }

          acts_as_voter
          # acts_as_taggable_on :interests

        #  has_many :posts, dependent: :destroy
        #  has_many :comments, dependent: :destroy
        #  has_many :votes, dependent: :destroy
        #  has_many :voted_posts, through: :votes, source: :votable, source_type: 'Post'
        #  has_many :voted_comments, through: :votes, source: :votable, source_type: 'Comment'
        #  has_many :notifications, dependent: :destroy

        after_create :build_default_profile

        def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0, 20]
            user.buiid_profile.save
          end
        end

        private
        def build_default_profile
          build_profile.save
        end

  # def avatar_thumbnail
  #   avatar.variant(resize_to_limit: [100, 100]).processed if avatar.attached?
  # rescue
  #   nil
  # end

  # def voted_for?(post)
  #   votes.exists?(votable: post)
  # end

  # def vote_for(post)
  #   votes.create(votable: post, vote_flag: true) unless voted_for?(post)
  # end

  # def unvote_for(post)
  #   votes.find_by(votable: post)&.destroy
  # end
  # def self.search(query)
  #   if query.present?
  #     where("name ILIKE :query OR email ILIKE :query", query: "%#{query}%")
  #   else
  #     all
  #   end
  # end

  # def self.admins
  #   where(role: 'admin')
  # end

  # def self.agents
  #   where(role: 'agent')
  # end

  # def self.general_users
  #   where(role: 'general_user')
  # end
end
