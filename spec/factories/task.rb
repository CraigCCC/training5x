FactoryBot.define do
  factory :task do
    title { Faker::FunnyName.name }
    content  { Faker::Lorem.paragraphs(number: 3) }
    status { :pending }
    priority { Task.priorities.to_a.sample[0] }
    start_at { DateTime.current }
    end_at { DateTime.current + 5.days }

    trait :title do
      title { 'Hello World' }
    end

    trait :processing do
      status { :processing }
    end

    trait :done do
      status { :done }
    end
  end
end
