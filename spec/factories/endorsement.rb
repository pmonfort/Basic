FactoryBot.define do
  factory :endorsement do
    skill { create(:skill) }
    endorsed_user_id { create(:user).id }
    endorser_user_id { create(:user).id }
  end
end
