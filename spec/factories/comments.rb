FactoryGirl.define do
  factory :comment do
    content "MyText"
user_id 1
commentable_type "MyString"
commentable_id 1
  end

end
