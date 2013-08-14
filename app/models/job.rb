class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :published, :title, :company, :job_type, :city, :valid_after
  classy_enum_attr :job_type
  classy_enum_attr :city
  default_scope order: 'jobs.updated_at DESC'
  
  scope :title_or_body_contains, ->(keyword) {
    where{(title =~ "%#{keyword}%") | (body =~ "%#{keyword}%") }
  }
  
  scope :in_location, ->(location) {
    where{city == location}
  }
  
  def self.search(option)
    list =  title_or_body_contains(option.keyword)
    list = list.in_location(option.location) unless option.location.empty?
    return list
  end
end
