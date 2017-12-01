FactoryBot.define do
  sequence(:email) { |n| "user#{n}@email.com"}
  factory :user do
    email 
    password "moonstone"
    first_name "John"
    last_name "Tester"
    admin false
  
    factory :user_admin do
      admin true
    end
  end  

 end
    