class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  # GET /tweets
  def index
    @page = params[:page] || 1
    @tweets = collection.page(@page)
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
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.turbo_stream { render :create }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  def update
    @tweet = resource

    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated.", status: :see_other }
        format.turbo_stream { render :update }
      else
        format.html { redirect_to @tweet, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet = resource
    @tweet.destroy!
    redirect_to authenticated_root_path, status: :see_other
  end

  private
    def collection
      Tweet.includes(:user, :likes, :comments).order(created_at: :desc)
    end

    def resource
      collection.find(params[:id])
    end

    def authorize_user!
      redirect_to authenticated_root_path, alert: "You are not authorized to perform this action." unless resource.user == current_user
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
