FactoryBot.define do
  factory :task do
    title { Faker::FunnyName.name }
    content  { Faker::Lorem.paragraphs(number: 3) }
    status { Task.statuses.to_a.sample[0] }
    priority { Task.priorities.to_a.sample[0] }
    start_at { Faker::Date.forward(days: 3) }
    end_at { Faker::Date.forward(days: 12) }
  end
end
