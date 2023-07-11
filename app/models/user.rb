class User < ApplicationRecord
  has_many :entities, as: :author
  has_many :groups
end
