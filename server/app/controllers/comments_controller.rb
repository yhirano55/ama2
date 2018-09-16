class CommentsController < ApplicationController
  def index
    authorize Comment
    relation = Comment.eager_load(:issue, :likes, user: { avatar_attachment: :blob })
    comments = OrderedCommentsQuery.new(relation, params.slice(:sort, :issue_id, :user_id)).all.page(params[:page])
    render json: CommentsWithPagination.new(data: comments, context: request), include: "**", serialize: CommentsWithPaginationSerializer
  end

  def create
    authorize Comment
    comment = current_user.comments.create!(comment_params)
    render json: comment, status: :created
  end

  def show
    render json: comment, include: "**"
  end

  def update
    comment.update!(comment_params)
    render json: comment
  end

  def destroy
    comment.destroy!
    render json: {}, status: :ok
  end

  private

    def comment_params
      params.require(:comment).permit(:issue_id, :content, :secret)
    end

    def comment
      @comment ||= Comment.find(params[:id]).tap(&method(:authorize))
    end
end
