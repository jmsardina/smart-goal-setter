FactoryGirl.define do
  factory :cheer do
    user
    cheerable_type "MyString"
    cheerable_id 1
  end

end
