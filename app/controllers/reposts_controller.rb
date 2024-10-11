class RepostsController < ApplicationController
  before_action :authenticate_user!

  # POST /reposts
  def create
    @tweet = resource
    @repost = current_user.tweets.new(origin: @tweet)

    respond_to do |format|
      if @repost.save
        format.html { redirect_to @repost, notice: "Repost was successfully created" }
        format.turbo_stream { flash.now[:notice] = "Repost was successfully created" }
      else
        format.html { redirect_to authenticated_root_path, notice: "There was an error during reposting the tweet" }
      end
    end
  end

  private

  def resource
    Tweet.find(params[:tweet_id])
  end
end
