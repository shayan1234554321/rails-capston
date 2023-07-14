class Group < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :entities, dependent: :destroy

  has_one_attached :icon

  validates :name, :icon, :author, presence: true
  validates :author, numericality: { only_integer: true }
end
