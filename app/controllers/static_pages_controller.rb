class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
    @option = SearchJob.new(keyword: params[:keyword] || '', location: params[:location] || '')
    @jobs = Job.search(@option).paginate(page: params[:page])
  end

  def about
  end

  def help
  end
end
