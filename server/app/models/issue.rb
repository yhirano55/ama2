# == Schema Information
#
# Table name: issues
#
#  id             :bigint(8)        not null, primary key
#  comments_count :integer          default(0), not null
#  description    :text             not null
#  likes_count    :integer          default(0), not null
#  secret         :boolean          default(FALSE), not null
#  subject        :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint(8)        not null
#
# Indexes
#
#  index_issues_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Issue < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  scope :most_liked, -> { order(likes_count: :desc) }
  scope :most_commented, -> { order(comments_count: :desc) }
  scope :not_secret, -> { where(secret: false) }
  scope :with_user_id, ->(user_id) { where(user_id: user_id, secret: false) if user_id }

  validates :subject,        presence: true, length: { maximum: 128   }
  validates :description,    presence: true, length: { maximum: 50000 }
  validates :comments_count, presence: true
  validates :likes_count,    presence: true
end
