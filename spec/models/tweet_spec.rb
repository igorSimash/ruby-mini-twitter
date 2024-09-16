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
require 'rails_helper'
RSpec.describe Tweet, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:origin).class_name('Tweet').optional }
    it { is_expected.to have_many(:retweets).class_name('Tweet').with_foreign_key('origin_id') }
  end

  context 'validations' do
    it { is_expected.to validate_length_of(:body).is_at_most(300) }
  end
end
