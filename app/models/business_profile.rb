class BusinessProfile < ApplicationRecord
  belongs_to :user, optional: true

  enum :approval_status, { pending: 0, approved: 1, rejected: 2 }
  # enum :business_type, { sole_proprietorship: 0, partnership: 1, corporation: 2, llc: 3, other: 4 }

  validates :company_name, presence: true
  validates :business_type, presence: true

  # def self.approved_profiles
  #   where(approval_status: :approved)
  # end

  # def self.pending_profiles
  #   where(approval_status: :pending)
  # end

  # def self.rejected_profiles
  #   where(approval_status: :rejected)
  # end

  # def approve!
  #   update(approval_status: :approved)
  # end

  # def reject!
  #   update(approval_status: :rejected)
  # end
  # def pending!
  #   update(approval_status: :pending)
  # end
  # def pending?
  #   approval_status == 'pending'
  # end
  # def approved?
  #   approval_status == 'approved'
  # end
  # def rejected?
  #   approval_status == 'rejected'
  # end
end
