require 'spec_helper.rb'

feature "Looking up promoter networks", js: true do
  before do
    PromoterNetwork.create!(name: 'Lookup 1')
    PromoterNetwork.create!(name: 'Lookup 2')
    PromoterNetwork.create!(name: 'Lookup 3')
    PromoterNetwork.create!(name: 'Lookup 4')
  end
  scenario "when paging promoter networks" do
    visit '/'
    fill_in "page", with: "1"
    fill_in "per_page", with: "3"
    click_on "Search"

    expect(page).to have_content("Lookup 1")
    expect(page).to have_content("Lookup 2")
    expect(page).to have_content("Lookup 3")
    expect(page).not_to have_content("Lookup 4")
  end
end