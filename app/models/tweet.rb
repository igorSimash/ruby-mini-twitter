# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  body       :text
#  user_id    :bigint           not null
#  origin_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :origin, class_name: "Tweet", optional: true
  has_many :retweets, class_name: "Tweet", foreign_key: "origin_id"

  validates :body, length: { maximum: 300 }
  validates :body, presence: true, unless: -> { origin_id.present? }
end
