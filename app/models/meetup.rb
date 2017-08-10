class Meetup < ApplicationRecord
  validates :title, presence: true
  has_many :comments
end
