class CommentsWithPaginationSerializer < ActiveModel::Serializer
  attributes :links
  has_many :data, serializer: CommentSerializer
end
