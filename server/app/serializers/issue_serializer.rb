class IssueSerializer < ActiveModel::Serializer
  attributes :id, :subject, :description, :comments_count, :likes_count, :created_at, :updated_at
  belongs_to :user

  def user
    object.user unless object.secret
  end
end
