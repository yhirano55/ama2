class OrderedIssuesQuery
  SORT_OPTIONS = %w[oldest newest most_commented most_liked].freeze

  def initialize(relation = Issue.all, params = {})
    @relation = relation
    @params = params
  end

  def all
    relation.
      public_send(sort_by).
      with_user_id(user_id)
  end

  private

    attr_reader :relation, :params

    def sort_by
      params[:sort].presence_in(SORT_OPTIONS) || :oldest
    end

    def user_id
      params[:user_id].presence
    end
end
