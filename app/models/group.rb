class Group < ApplicationRecord
  belongs_to :user

  has_many :entities, dependent: :destroy

  has_one_attached :icon
end
