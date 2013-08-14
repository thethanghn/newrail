namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
    make_jobs
	end
end

def make_users
	admin = User.create!(name: 'Nguyen The Thang', email: 'thethanghn@gmail.com', password: 'password', password_confirmation: 'password')
	admin.toggle!(:admin)
	99.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password = 'password'
		User.create!(name: name, email: email, password: password, password_confirmation: password)
	end
end

def make_microposts
	users = User.all(limit: 10)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create(content: content)}
	end
end

def make_relationships
	users = User.all()
	user = users.first
	followed_users = users[2..50]
	followers = users[3..40]
	followed_users.each { |followed| user.follow!(followed)}
	followers.each {|follower| follower.follow!(user)}
end

def make_jobs
  users = User.all()
  23.times do
    users.each do |user| 
      title = Faker::Lorem.sentence(5)
      body  = Faker::Lorem.paragraphs(3)
      company = Faker::Company.name
      job_type = JobType.all.sample
      city = City.all.sample
      valid_after = (5..45).to_a.sample
      user.jobs.create(title: title, body: body, job_type: job_type, city: city, company: company, published: Random.rand(100).days.ago, valid_after: valid_after )
    end
  end
end
