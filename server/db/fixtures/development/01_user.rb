(1..30).each do |n|
  User.seed(:uid) do |user|
    user.id       = n
    user.uid      = n
    user.nickname = "test#{n}"
    user.role     = User.roles.keys.sample
  end
end
