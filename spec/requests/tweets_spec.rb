require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  let(:user) { User.create(username: "usernameex", email: "user@example.com", password: "password123") }
  let(:tweet) { Tweet.create(user: user, body: "This is a tweet") }

  before do
    sign_in user
  end

  describe 'GET /tweets' do
      it 'returns a success response' do
        get tweets_path
        expect(response).to be_successful
      end

    it 'renders the index template' do
      get tweets_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /tweets/:id' do
    it 'returns a success response' do
      get tweet_path(tweet)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get tweet_path(tweet)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /tweets/new' do
    it 'returns a success response' do
      get new_tweet_path
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get new_tweet_path
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /tweets/:id/edit' do
    it 'returns a success response' do
      get edit_tweet_path(tweet)
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      get edit_tweet_path(tweet)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /tweets' do
    context 'with valid params' do
      let(:valid_attributes) { { tweet: { body: 'This is a new tweet' } } }

      it 'creates a new Tweet' do
        expect {
          post tweets_path, params: valid_attributes
        }.to change(Tweet, :count).by(1)
      end

      it 'redirects to the created tweet' do
        post tweets_path, params: valid_attributes
        expect(response).to redirect_to(Tweet.last)
        expect(flash[:notice]).to eq('Tweet was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { tweet: { body: '' } } }

      it 'does not create a new Tweet' do
        expect {
          post tweets_path, params: invalid_attributes
        }.to change(Tweet, :count).by(0)
      end

      it 'renders the new template with status unprocessable_entity' do
        post tweets_path, params: invalid_attributes
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /tweets/:id' do
    context 'with valid params' do
      let(:new_attributes) { { tweet: { body: 'Updated tweet' } } }

      it 'updates the requested tweet' do
        patch tweet_path(tweet), params: new_attributes
        tweet.reload
        expect(tweet.body).to eq('Updated tweet')
      end

      it 'redirects to the tweet' do
        patch tweet_path(tweet), params: new_attributes
        expect(response).to redirect_to(tweet)
        expect(flash[:notice]).to eq('Tweet was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 'does not update the tweet' do
        patch tweet_path(tweet), params: { tweet: { body: '' } }
        tweet.reload
        expect(tweet.body).not_to eq('')
      end

      it 'renders the edit template with status unprocessable_entity' do
        patch tweet_path(tweet), params: { tweet: { body: '' } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /tweets/:id' do
    it 'destroys the requested tweet' do
      tweet
      expect {
        delete tweet_path(tweet)
      }.to change(Tweet, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete tweet_path(tweet)
      expect(response).to redirect_to(authenticated_root_path)
    end
  end

  describe 'Authorization' do
    let(:other_user) { User.create(username: "usernameex2", email: "user2@example.com", password: "password1232") }

    before do
      sign_out user
      sign_in other_user
    end

    it 'redirects from edit if not authorized' do
      get edit_tweet_path(tweet)
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to eq('You are not authorized to perform this action.')
    end

    it 'redirects from update if not authorized' do
      patch tweet_path(tweet), params: { tweet: { body: 'Updated' } }
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to eq('You are not authorized to perform this action.')
    end

    it 'redirects from destroy if not authorized' do
      delete tweet_path(tweet)
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to eq('You are not authorized to perform this action.')
    end
  end
end
