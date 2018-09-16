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

require "rails_helper"

RSpec.describe Issue, type: :model do
  describe "factory" do
    subject { build(:issue) }

    it { is_expected.to be_valid }
  end
end
