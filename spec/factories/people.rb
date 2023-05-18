FactoryBot.define do
  factory :person do
    first_name { "Person" }
    sequence(:last_name)
  end
end
