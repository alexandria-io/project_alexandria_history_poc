# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    archive_id 1
    record_text "MyText"
    record_type ""
  end
end
