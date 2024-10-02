class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  # GET /tweets
  def index
    @page = params[:page] || 1
    @tweets = Tweet.includes(:user, :likes, :comments)
      .order(created_at: :desc)
      .page(@page)
  end

  # GET /tweets/1
  def show
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      redirect_to @tweet, notice: "Tweet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: "Tweet was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy!
    redirect_to authenticated_root_path, notice: "Tweet was successfully destroyed.", status: :see_other
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def authorize_user!
      redirect_to authenticated_root_path, alert: "You are not authorized to perform this action." unless @tweet.user == current_user
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
