class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :user

      t.string :title
      t.text :description
      t.boolean :is_featured
      t.string :label

      t.timestamps
    end
  end
end
