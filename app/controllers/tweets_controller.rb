class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :check_author!, only: [ :edit, :update, :destroy ]

  # GET /tweets
  def index
    @tweets = collection.page(params[:page]).per(20)
  end

  # GET /tweets/1
  def show
    @tweet = resource
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.new
  end

  # GET /tweets/1/edit
  def edit
    @tweet = resource
  end

  # POST /tweets
  def create
    @tweet = current_user.tweets.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        flash[:notice] = "Tweet was successfully created"

        format.html { redirect_to @tweet }
        format.turbo_stream
      else
        flash[:alert] = "There was an error during creating the tweet"

        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new }
      end
    end
  end

  # PATCH/PUT /tweets/1
  def update
    @tweet = resource

    respond_to do |format|
      if @tweet.update(tweet_params)
        flash[:notice] = "Tweet was successfully updated"

        format.html { redirect_to @tweet, status: :see_other }
        format.turbo_stream
      else
        flash[:alert] = "There was an error during updating the tweet"

        format.html { redirect_to @tweet, status: :unprocessable_entity }
        format.turbo_stream { render :edit }
      end
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet = resource

    if @tweet.destroy
      flash[:notice] = "Tweet was successfully deleted"
    else
      flash[:alert] = "There was an error deleting the tweet"
    end

    redirect_to authenticated_root_path, status: :see_other
  end

  private

  def collection
    Tweet.includes(:user, :likes, :comments).recent
  end

  def resource
    collection.find(params[:id])
  end

  def check_author!
    redirect_to authenticated_root_path,
      alert: "You are not authorized to perform this action." if resource.user != current_user
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
