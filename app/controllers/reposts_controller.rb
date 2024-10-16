class RepostsController < ApplicationController
  before_action :authenticate_user!

  # POST /reposts
  def create
    @tweet = resource
    @repost = current_user.tweets.new(origin: @tweet)

    respond_to do |format|
      if @repost.save
        flash[:notice] = "Repost was successfully created"

        format.html { redirect_to @repost }
        format.turbo_stream
      else
        flash[:alert] = "There was an error during reposting the tweet"

        format.html { redirect_to authenticated_root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def resource
    Tweet.find(params[:tweet_id])
  end
end
