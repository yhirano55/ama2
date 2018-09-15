class CommentSerializer < ActiveModel::Serializer
  attributes :id, :issue_id, :content, :likes_count, :created_at, :updated_at
  belongs_to :user

  def user
    object.user unless object.secret
  end
end
