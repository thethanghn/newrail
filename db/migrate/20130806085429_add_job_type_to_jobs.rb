class AddJobTypeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_type, :string
    add_index :jobs, :job_type
  end
end
