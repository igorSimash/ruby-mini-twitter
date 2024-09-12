class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :origin, class_name: "Tweet", optional: true
  has_many :retweets, class_name: "Tweet", foreign_key: "origin_id"

  validates :body, presence: true, length: { maximum: 300 }
end
