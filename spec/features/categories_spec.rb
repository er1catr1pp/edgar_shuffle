require 'rails_helper'

describe "shuffle and un-shuffle category", js: true do

  describe "cateogries index", type: :feature do

    describe "shuffle a category" do

      let!(:category) { FactoryGirl.create(:category) }

      it "shuffles the category and takes you to the queue" do
        visit "/categories"
        expect(page).to have_css("h2", :text => "Categories")
        expect(page).to have_css(".category-name", :text => category.name)
        find(:css, 'i.fa.fa-random').click
        expect(page).to have_css("h2", :text => "Queue")
        expect(page).to have_css(".alert-success", :text => "The #{category.name} category has been shuffled!")
      end

    end

    describe "un-shuffle a category" do

      let!(:category) { FactoryGirl.create(:category) }

      it "un-shuffles the category and takes you to the queue" do
        visit "/categories"
        expect(page).to have_css("h2", :text => "Categories")
        expect(page).to have_css(".category-name", :text => category.name)
        find(:css, 'i.fa.fa-list-ul').click
        expect(page).to have_css("h2", :text => "Queue")
        expect(page).to have_css(".alert-success", :text => "The #{category.name} category has been un-shuffled!")
      end
    end

  end

end