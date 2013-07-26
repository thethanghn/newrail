require 'spec_helper'

describe "AuthenticationPages" do

	subject {page}

	describe "signin page" do
		before {visit signin_path}

		describe "with invalid information" do
			before {click_button "Sign in"}

			it { should have_selector('h1', text: 'Sign in')}
			it { should have_selector('div.alert.alert-error', text: 'Invalid')}
		end

		describe "with valid information" do
			let (:user) { FactoryGirl.create(:user)}
			before do
				fill_in "Email",		with: user.email
				fill_in "Password",		with: user.password
				click_button "Sign in"
			end

			it { should have_selector('h1', text: 'Sign in')}
			it { should have_link('Profile', href: user_path(user))}
			it { should have_link('Sign out', href: signout_path)}
			it { should_not have_link('Sign in', href: signin_path)}
		end

		describe "after visiting another page" do
			before { click_link "Home"}
			it { should_not have_selector('div.alert.alert-error')}
		end
	end

  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:uesr) {FactoryGirl.create(:user)}
      describe "in the Users controller" do
        describe "visiting the following page" do
          before {visit following_user_path(user)}
          it { should have_selector('title', text: 'Sign in')}
        end
        
        describe "visiting the follower page" do
          before {visit followers_user_path(user)}
          it {should have_selector('title', text: 'Sign in')}
        end
      end
      
      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path}
          specify {response.should redirect_to(signin_path)}
        end
        describe "submitting to the destroy action" do
          before { delete relationships_path(1)}
          specify {response.should redirect_to(signin_path)}
        end
      end
      
    end
  end
end
