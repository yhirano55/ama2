class IssuesController < ApplicationController
  def index
    authorize Issue
    relation = Issue.eager_load(user: { avatar_attachment: :blob })
    issues = OrderedIssuesQuery.new(relation, params.slice(:sort, :user_id)).all.page(params[:page])
    render json: IssuesWithPagination.new(data: issues, context: request), include: "**", serialize: IssuesWithPaginationSerializer
  end

  def create
    authorize Issue
    issue = current_user.issues.create!(issue_params)
    render json: issue, status: :created
  end

  def show
    render json: issue
  end

  def update
    issue.update!(issue_params)
    render json: issue
  end

  def destroy
    issue.destroy!
    render json: {}, status: :ok
  end

  private

    def issue_params
      params.require(:issue).permit(:subject, :description, :secret)
    end

    def issue
      @issue ||= Issue.eager_load(:likes).find(params[:id]).tap(&method(:authorize))
    end
end
