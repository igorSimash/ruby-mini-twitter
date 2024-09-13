require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(username: "usernameex", email: "user@example.com", password: "password123") }
  let(:tweet) { Tweet.new(user: user, body: "This is a tweet") }

  subject { Like.new(user: user, tweet: tweet) }

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:tweet) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:tweet_id) }
  end
end
