class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :published, :title
end
