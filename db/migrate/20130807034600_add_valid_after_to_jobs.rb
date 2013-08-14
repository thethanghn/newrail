class AddValidAfterToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :valid_after, :integer
  end
end
