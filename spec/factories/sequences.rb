FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end
  sequence :name do |n|
    "name#{n}"
  end
  sequence :_id do |n|
    n
  end
end
