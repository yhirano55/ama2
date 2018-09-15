Issue.all.each do |issue|
  Comment.seed do |comment|
    comment.issue    = issue
    comment.user_id  = User.admin.pluck(:id).sample
    comment.content  = Faker::Lorem.paragraph
    comment.secret   = [true, false].sample
  end

  Comment.seed do |comment|
    comment.issue    = issue
    comment.user_id  = User.guest.pluck(:id).sample
    comment.content  = Faker::Lorem.paragraph
    comment.secret   = [true, false].sample
  end
end
