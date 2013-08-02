require 'spec_helper'

describe RelationshipsController do
  let (:user) { FactoryGirl.create(:user)}
  let (:other_user) { FactoryGirl.create(:other_user)}
  
  before { sign_in(user)}
  
  describe "create a relationship with ajax" do
    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.should change(Relationship, :count).by(1)
    end

  it "should response with success" do
    xhr :post, :create, relationship: { followed_id: other_user.id }
    response.should be_success
  end

  end
  
end