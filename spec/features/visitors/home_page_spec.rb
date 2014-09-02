# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  scenario 'visit the home page' do
  	FactoryGirl.create :event
    visit root_path
    expect(page).to have_content 'SundayMondayTuesdayWednesdayThursdayFridaySaturday'
  end

end
