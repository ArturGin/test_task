class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :set_posts, only: :index

  def index
    render json: @posts,
           each_serializer: PostSerializer,
           status: :ok
  end

  def create
    result = CreatePost.call(title: params[:title],
                             body: params[:body],
                             login: params[:login],
                             ip: params[:ip])
    if result.success?
      render json: result.post, serializer: PostSerializer,
             status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def set_posts
    @posts = Post.includes(:user).by_average(params[:average])
                 .limit(params[:limit])
  end
end
