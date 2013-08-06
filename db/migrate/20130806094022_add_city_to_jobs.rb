class AddCityToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :city, :string
    add_index :jobs, :city
  end
end
