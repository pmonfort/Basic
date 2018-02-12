class CreateEndorsements < ActiveRecord::Migration[5.1]
  def change
    create_table :endorsements do |t|
      t.integer  "endorsed_user_id"
      t.integer  "endorser_user_id"
      t.timestamps
    end

    add_reference :endorsements, :skill, index: true
  end
end
