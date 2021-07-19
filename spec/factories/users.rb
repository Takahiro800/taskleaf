FactoryBot.define do
  factory :admin_user, class: User do
    name { "テストユーザー" }
    email { "test1@example.com" }
    password_digest { "password" }
  end
end
