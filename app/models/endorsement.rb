class Endorsement < ActiveRecord::Base
  belongs_to :endorsed, class_name: User.name, foreign_key: :endorsed_user_id
  belongs_to :endorser, class_name: User.name, foreign_key: :endorser_user_id
  belongs_to :skill

  validates_presence_of :skill_id
  validates_presence_of :endorser
  validates_presence_of :endorsed
end
