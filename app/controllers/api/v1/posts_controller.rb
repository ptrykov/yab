class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  guest_users_can_view

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts = paginate(@posts)
    authorize @posts

    render json: @posts, each_serializer: Api::V1::PostSerializer, meta: meta_attributes(@posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @post, serializer: Api::V1::PostSerializer
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      render json: @post, status: :created, location: api_v1_post_path(@post), serializer: Api::V1::PostSerializer
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    head :no_content
  end

  private

    def set_post
      @post = Post.find(params[:id])
      authorize @post
    end

    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
