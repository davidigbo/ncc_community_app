class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :avatar
         enum role: { general_user: 0, agent:1, admin: 2 }

         validates :role, presence: true

  def admin?
    role == 'admin'
  end

  def agent?
    role == 'agent'
  end

  def general_user?
    role == 'general_user'
  end
  
  def avatar_thumbnail
    avatar.variant(resize_to_limit: [100, 100]).processed if avatar.attached?
  rescue
    nil
  end

  acts_as_voter

  def voted_for?(post)
    votes.exists?(votable: post)
  end
  def vote_for(post)
    votes.create(votable: post, vote_flag: true) unless voted_for?(post)
  end
  def unvote_for(post)
    votes.find_by(votable: post)&.destroy
  end
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
