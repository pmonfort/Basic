class Skill < ActiveRecord::Base
  before_validation :set_slug, on: :create
  has_many :endorsements, dependent: :delete_all
  has_many :users, -> { distinct }, through: :endorsements

  def set_slug
    self.slug = name.to_s.gsub('&', ' and ').parameterize
  end

  def endorsements_count_by_user(user_id)
    endorsements.select { |e| e.endorsed_user_id == user_id }.count
  end

  def endorser_by_user?(endorsed_user_id, endorser_user_id)
    endorsements.select do |e|
      e.endorser_user_id == endorser_user_id &&
        e.endorsed_user_id == endorsed_user_id
    end.any?
  end
end
