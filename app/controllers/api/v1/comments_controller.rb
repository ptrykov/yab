class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :update, :destroy]
  guest_users_can_view

  # GET /comments
  # GET /comments.json
  def index
    @comments = @post.comments.all
    @comments = paginate(@comments)
    authorize @comments

    render json: @comments, each_serializer: Api::V1::CommentSerializer, meta: meta_attributes(@comments)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    render json: @comment, serializer: Api::V1::CommentSerializer
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created, location: api_v1_post_comments_path(@post, @comment), serializer: Api::V1::CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    head :no_content
  end

  private

    def set_comment
      @comment = @post.comments.find(params[:id])
      authorize @comment
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end
    
    def set_post
      @post = Post.find(params[:post_id])
    end
end
