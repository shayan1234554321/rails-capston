class Entity < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :group

  validates :name, presence: true
  validates :author, :group, presence: true, numericality: { only_integer: true }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
