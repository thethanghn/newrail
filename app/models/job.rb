class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :published, :title, :company
  default_scope order: 'jobs.updated_at DESC'
end
