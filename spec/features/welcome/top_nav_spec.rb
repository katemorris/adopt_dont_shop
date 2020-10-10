require 'rails_helper'

describe "Navigation Requests Spec" do

  describe "Navigation should be available" do
    it "should show the navigation on all pages" do
      visit '/'
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      click_link('Pets')

      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      click_link('Shelters')
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')
    end
  end
end
