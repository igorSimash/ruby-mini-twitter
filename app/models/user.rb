# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  username            :string           default(""), not null
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  remember_created_at :datetime
#
class User < ApplicationRecord
  attr_accessor :login

  devise :database_authenticatable, :registerable, :validatable, :rememberable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 },
      format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain Latin letters, numbers, and underscores" }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      [
        "lower(username) = :value OR lower(email) = :value",
        { value: login.strip.downcase }
      ]).first
  end
end
