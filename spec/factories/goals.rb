# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    name "My Awesome Goal"
    details "Some awesome details about my goal"
    private_goal true
    user_id 1
  end
end
