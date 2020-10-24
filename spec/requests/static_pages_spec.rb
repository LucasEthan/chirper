require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Home page" do
    it "should have the content 'Lorem Ipsum'" do
      visit "/"
      expect(page).to have_content("Lorem Ipsum")
    end
  end
end
