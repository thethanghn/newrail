require 'spec_helper'

describe "User Page" do
  subject {page}
  describe "GET /user_pages" do
  	before {visit signup_path }

    it {should have_selector("h1", text: "Signup")}
  end
  
  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user)}
    let(:other_user) {FactoryGirl.create(:user)}
    before { user.follow!(other_user)}
    
    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end
      it { should have_selector('title', text: full_title('Following'))}
      it { should have_selector('h3', text: 'Following')}
      it { should have_link(other_user.name, href: user_path(other_user))}
    end
    
    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end
      it { should have_selector('title', text: full_title('Following'))}
      it { should have_selector('h3', text: 'Following')}
      it { should have_link(user.name, href: user_path(user))}
    end
    
  end
  
end

describe "Profile page" do
	let(:user) { FactoryGirl.create(:user)}
	before { visit user_path(user)}

	it {should have_selector('h1', text: user.name)}
	it {should have_selector('title', text: user.name)}
  
  describe "follow/unfollow buttons" do
    let(:other_user) { FactoryGirl.create(:user)}
    before { sign_in user}
    
    describe "follow an user" do
      before { visit user_path(other_user)}
      it "should increment followed user count" do
        expect do
          click_button "Follow"
        end.to change(user.followed_users, :count).by(1)
      end
      
      it "should increment user's following user count" do
        expect do
          click_button "Follow"
        end.to change(other_user.followers, :count).by(1)
      end
      
      describe "toggle the button" do
        before { click_button "Follow"}
        
        it {should have_selector('input', value: 'Unfollow')}
      end
    end
    
    describe "unfollowing an user" do
      before do
        user.follow!(other_user)
        visit user_path(other_user) 
      end
        
      it "should decrease user's follower" do
        expect do
          click_button "Unfollow"
        end.to change(other_user.followers, :count).by(1)
      end
      
      it "should decrease followed user count" do
        expect do
          click_button "Unfollow"
        end.to change(user.followed_users, :count).by(1)
      end
      
      describe "toggle follow button" do
        before { click_button "Unfollow" }
        it {should have_selector('input', value: "Follow")}
      end
    end 
  end
  
end

describe "Signup page" do

	before {visit signup_path}

	let(:submit) {"Create my account"}

	describe "with invalid information" do
		it "should not create a user" do
			expect {click_button submit}.not_to change(User, :count)
		end
	end

	describe "with valid information" do
		before do
			fill_in "Name",			with: "Example User"
			fill_in "Email",		with: "user@example.com"
			fill_in "Password", 	with: "foobar"
			fill_in "Confirmation",	with: "foobar"
		end

		it "should create a user" do
			expect { click_button "Create my account"}.to change(User, :count).by(1)
		end
	end

	describe "with error message" do
		before {click_button submit}
		it "should show error messages" do
			page.should have_selector('title', text: 'Signup')
			page.should have_content('error')
		end
	end

end
