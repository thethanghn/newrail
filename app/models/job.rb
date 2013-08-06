class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :published, :title, :company, :job_type, :city
  classy_enum_attr :job_type
  classy_enum_attr :city
  default_scope order: 'jobs.updated_at DESC'
end
