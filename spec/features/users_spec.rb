require 'spec_helper'

describe 'Users' do
  describe 'List of users' do
    before(:each) do
      visit users_url
    end

    it 'should have text "Listing users"' do
      page.should have_content 'Listing users'
    end

    it 'should have link "New User"' do
      find_link('New User').visible?.should be_true
    end
  end
end
