FactoryGirl.define do
  factory :user do
    firstname "Ivan"
    lastname "Young"
    email
    password "password"
    password_confirmation "password"

    factory :admin do
      email
      after(:create) do |user|
        user.roles << FactoryGirl.create(:role, :admin)
      end
    end
  end

end
