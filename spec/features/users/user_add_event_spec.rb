feature 'adding event' do
  scenario 'logged in user sees the event on the my calendar page' do
    event = FactoryGirl.create :event
    visit root_path
    set_omniauth()
    click_link_or_button 'Sign up'
    click_link event.title 
    click_button "calendar-add-button"
    click_link "My Calendar"
    expect(page).to have_content event.title
  end

  scenario 'not logged in user cannot add the event to my calendar' do
    event = FactoryGirl.create :event
    visit root_path
    click_link event.title
    expect(page).not_to have_content "Add to calendar"
    expect(page).to have_content "Login"
  end

end

