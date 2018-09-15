class IssuesWithPaginationSerializer < ActiveModel::Serializer
  attributes :links
  has_many :data, serializer: IssueSerializer
end
