FactoryGirl.define do
  factory :role do
    name "MyString"
  end

  trait :admin do
    name "Admin"
  end
end
