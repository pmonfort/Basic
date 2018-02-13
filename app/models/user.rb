class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                      message: 'not a valid email format'
                    }
  has_many :endorsements, foreign_key: :endorsed_user_id, dependent: :delete_all
  has_many :skills, -> { distinct }, through: :endorsements

  def add_endorsement(name, endorser_user_id)
    slug = name.to_s.gsub('&', ' and ').parameterize
    skill = skills.find { |skill| skill.slug == slug }
    skill = Skill.create(name: name, slug: slug) unless skill

    return unless skill.endorsements.by_endorser(endorser_user_id).empty?

    self.endorsements.create(
      skill_id: skill.id,
      endorser_user_id: endorser_user_id
    )
  end

  def remove_endorsement(name, endorser_user_id)
    slug = name.to_s.gsub('&', ' and ').parameterize
    skill = skills.find { |skill| skill.slug == slug }
    return unless skill

    endorsements = self.endorsements.where(
      skill_id: skill.id,
      endorser_user_id: endorser_user_id
    )
    endorsements.each(&:destroy)
  end
end
