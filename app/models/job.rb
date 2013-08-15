class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :published, :title, :company, :job_type, :job_category, :city, :valid_after
  classy_enum_attr :job_type
  classy_enum_attr :city
  classy_enum_attr :job_category
  default_scope order: 'jobs.updated_at DESC'
  
  scope :title_or_body_contains, ->(keyword) {
    where{(title =~ "%#{keyword}%") | (body =~ "%#{keyword}%") }
  }
  
  scope :in_location_any, ->(locations) {
    where{city >> locations}
  }
  
  scope :with_job_type_any, ->(types) {
    where{job_type >> types}
  }
  
  scope :with_job_category, ->(category) {
    where{job_category == category}
  }
  
  def self.search(option)
    list =  title_or_body_contains(option.keyword)
    list = list.in_location_any(option.locations) unless option.locations.empty?
    list = list.with_job_category(option.job_category) unless option.job_category.empty?
    list = list.with_job_type_any(option.job_types) unless option.job_types.empty?
    return list
  end
end
