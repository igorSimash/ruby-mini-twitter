require 'rails_helper'


RSpec.describe "Reposts", type: :request do
  include_context :authenticated_user

  let(:tweet) { create(:tweet, user: user) }

  describe "POST /reposts" do
    let(:repost) { Tweet.last }

    context "when reposting a tweet" do
      it "creates a new repost" do
        expect { post tweet_reposts_path(tweet) }.to change { Tweet.where(origin: tweet).count }.by(1)

        expect(repost.origin).to eq(tweet)
        expect(repost.user).to eq(user)
        expect(flash[:notice]).to eq("Repost was successfully created")
      end
    end
  end
end
