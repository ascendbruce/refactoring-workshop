class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :nickname
      t.text :bio

      t.timestamps
    end
  end
end
