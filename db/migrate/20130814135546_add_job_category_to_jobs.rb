class AddJobCategoryToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_category, :string
    add_index :jobs, :job_category
  end
end
