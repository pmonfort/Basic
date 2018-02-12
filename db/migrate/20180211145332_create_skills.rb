class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.string   "name"
      t.string   "slug"
      t.timestamps
    end

    add_reference :skills, :user, index: true
  end
end
