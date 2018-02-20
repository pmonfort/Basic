FactoryBot.define do
  factory :skill do
    name { Faker::Superhero.power }
  end
end
