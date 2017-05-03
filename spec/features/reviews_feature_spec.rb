require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    create_restaurant
    click_link 'Review Sams Chicken'
    fill_in 'Thoughts', with: 'Got my phone stolen outside ffs'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link('Sams Chicken')
    expect(page).to have_content 'Got my phone stolen outside ffs'
    expect(page).to have_content '3'
  end
end
