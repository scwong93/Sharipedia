FactoryGirl.define do
  factory :wiki do
    title Faker::Company.bs
    body Faker::Company.bs
    private false
  end
end
