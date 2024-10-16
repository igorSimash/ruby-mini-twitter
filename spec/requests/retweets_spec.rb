require 'rails_helper'


RSpec.describe "Retweets", type: :request do
  include_context :authenticated_user

  let(:tweet) { create(:tweet, user: user) }
  let(:retweet_body) { "This is new retweet." }
  let(:params) { { tweet: { body: retweet_body } } }

  describe "GET #new" do
    it "returns a successful response" do
      get new_tweet_retweet_path(tweet)

      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:retweet) { Tweet.last }

    context "with valid params" do
      it "creates a new retweet" do
        expect { post tweet_retweets_path(tweet), params: params }
          .to change { Tweet.where(origin: tweet).count }.by(1)

        expect(retweet.origin).to eq(tweet)
        expect(retweet.body).to eq(retweet_body)
        expect(flash[:notice]).to eq("Retweet was successfully created")
      end
    end
  end
end
