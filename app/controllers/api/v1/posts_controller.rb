class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :set_posts, only: :index

  def index
    render json: @posts,
           meta: { total_pages: @posts.total_pages, total_count: @posts.total_count },
           root: :posts,
           adapter: :json,
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
    @posts = Post.by_average(params[:average])
                 .page(params[:page])
                 .per(params[:limit])
  end
end
