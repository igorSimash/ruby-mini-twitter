class RetweetsController < ApplicationController
  before_action :authenticate_user!

  # GET /retweets/new
  def new
    @tweet = resource
    @retweet = current_user.tweets.new
  end

  # POST /retweets
  def create
    @retweet = current_user.tweets.new(retweet_params.merge(origin: resource))

    respond_to do |format|
      if @retweet.save
        flash[:notice] = "Retweet was successfully created"

        format.html { redirect_to @retweet }
        format.turbo_stream
      else
        flash[:alert] = "There was an error during retweeting the tweet"

        format.html { redirect_to authenticated_root_path, status: :unprocessable_entity }
        format.turbo_stream { render :new }
      end
    end
  end

  private

  def resource
    Tweet.find(params[:tweet_id])
  end

  def retweet_params
    params.require(:tweet).permit(:body)
  end
end
