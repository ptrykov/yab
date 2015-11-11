FactoryGirl.define do
  factory :user do
    firstname "Ivan"
    lastname "Young"
    email "example@example.com"
    password "password"
    password_confirmation "password"
  end

end
