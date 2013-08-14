class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
    @option = SearchJob.new(
      keyword: params[:keyword] || '', 
      job_category: params[:job_category] || '', 
      job_types: params[:job_types] || [],
      locations: params[:locations] || []
    )
    @jobs = Job.search(@option).paginate(page: params[:page])
  end

  def about
  end

  def help
  end
end
