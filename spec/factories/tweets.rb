# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    record_id 1
    tweet_text "MyText"
  end
end
