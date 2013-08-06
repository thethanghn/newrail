class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.references :user

      t.timestamps
    end
    add_index :jobs, :user_id
  end
end
