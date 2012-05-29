# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    user_id 1
    venue_id 1
    comment "MyText"
    rating 1
  end
end
