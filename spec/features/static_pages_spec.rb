require 'spec_helper'

describe "StaticPages" do

	subject {page}

	describe "Home Page" do
		before { visit root_path }

		it { should have_selector("h1", text: "Welcome to the Sample App") }

		describe "For signed-in users"  do
			let(:user) { FactoryGirl.create(:user)}
			before do
				FactoryGirl.create(:micropost, user: user, content: 'Lorem')
				FactoryGirl.create(:micropost, user: user, content: 'Ipsum')
				sign_in user
				visit root_path
			end

			it "should render the users's feed" do
				user.feed.each do |item|
					page.should have_selector("li##{item.id}", text: item.content)
				end
			end

			describe "following/followers coutns" do
				let(:other_user) {FactoryGirl.create(:user)}
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", href: following_user_path(user))}
				it { should have_link("1 follower", href: followers_user_path(user))}
			end

		end

	end

end
