# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    record_id 1
    tweet_text "MyText"
    created_date "12-1-10"
  end
end
