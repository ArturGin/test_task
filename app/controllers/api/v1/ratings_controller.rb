class Api::V1::RatingsController < Api::V1::ApplicationController
  before_action :set_user, :set_post

  def create
    rating = Rating.new(user: @user, post: @post, value: ratings_params[:value])
    if rating.save
      render json: { average: @post.average_rating }, status: :ok
    else
      render json: { error: rating.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: ratings_params[:user_id])
    render json: { message: 'User not found' }, status: :not_found if @user.nil?
  end

  def set_post
    @post = Post.find_by(id: ratings_params[:post_id])
    render json: { message: 'Post not found' }, status: :not_found if @post.nil?
  end

  def ratings_params
    params.permit(:user_id, :post_id, :value)
  end
end
