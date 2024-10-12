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
        format.html { redirect_to @retweet, notice: "Retweet was successfully created" }
        format.turbo_stream { flash.now[:notice] = "Retweet was successfully created" }
      else
        format.html { redirect_to authenticated_root_path, notice: "There was an error during retweeting the tweet" }
        format.turbo_stream { render :new }
      end
    end
  end

  # GET /retweets/:id/edit
  def edit
    @retweet = current_user.tweets.find(params[:id])
  end

  # PATCH/PUT /retweets/:id
  def update
    @retweet = current_user.tweets.find(params[:id])

    respond_to do |format|
      if @retweet.update(tweet_params)
        format.html { redirect_to @retweet, notice: "Retweet was successfully updated", status: :see_other }
        format.turbo_stream { flash.now[:notice] = "Retweet was successfully updated" }
      else
        format.html { redirect_to @retweet, status: :unprocessable_entity }
        format.turbo_stream { render :edit }
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
