FactoryGirl.define do
  factory :user do
    firstname "Ivan"
    lastname "Young"
    email
    password "password"
    password_confirmation "password"
  end

end
