require 'spec_helper'

describe 'Users' do
  describe 'List of users' do

    it 'should have text "Listing users"' do
      # always use `path` helper, using `url` helper has unintended affects
      visit users_path
      page.should have_content 'Listing users'
    end

    it 'should have link "New User"' do
      visit users_path
      find_link('New User').visible?.should be_true
    end

    it 'should be able to delete a user', :js => true do
      # must have for `:js => true` specs (though using selenium-webdriver)
      DatabaseCleaner.clean

      user = FactoryGirl.create(:user)

      visit users_path

      # a user is indeed created
      page.should have_content('joelam')

      # click the `alert` dialog (called in app/assets/javascripts/users.js)
      expectation = expect do
          click_link('foo')
          alert = page.driver.browser.switch_to.alert
          alert.accept
        end

      # check that `delete` user indeed works
      expectation.to change(User, :count).by(-1)
    end
  end
end
