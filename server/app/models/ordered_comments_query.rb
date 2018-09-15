class OrderedCommentsQuery
  SORT_OPTIONS = %w[oldest newest most_liked].freeze

  def initialize(relation = Comment.all, params = {})
    @relation = relation
    @params = params
  end

  def all
    relation.
      public_send(sort_by).
      with_issue_id(issue_id).
      with_user_id(user_id)
  end

  private

    attr_reader :relation, :params

    def sort_by
      params[:sort].presence_in(SORT_OPTIONS) || :newest
    end

    def issue_id
      params[:issue_id].presence
    end

    def user_id
      params[:user_id].presence
    end
end
