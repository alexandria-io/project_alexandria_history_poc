# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :archive_item do
    archive_id 1
    item_term "MyString"
    item_type "MyString"
  end
end
