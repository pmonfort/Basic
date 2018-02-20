FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'dummy-password'

    factory :user_with_skills do
      after(:create) do |user|
        4.times do
          create(:endorsement, endorsed_user_id: user.id)
        end
      end
    end
  end
end
