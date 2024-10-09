# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tweet_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:tweet) }
  end

  context 'validations' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user: user) }

    subject { create(:like, user: user, tweet: tweet) }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:tweet_id) }
  end
end
