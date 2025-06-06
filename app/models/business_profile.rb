class BusinessProfile < ApplicationRecord
  belongs_to :user

  enum :approval_status, { pending: 0, approved: 1, rejected: 2 }
  # enum :business_type, { sole_proprietorship: 0, partnership: 1, corporation: 2, llc: 3, other: 4 }

  validates :company_name, :business_type, presence: true
end
