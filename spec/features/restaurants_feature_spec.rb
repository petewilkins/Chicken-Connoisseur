require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      create_restaurant
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Sams Chicken'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Sams Chicken'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Sams Chicken'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user cannot add a restaurant unless signed in' do
      visit('/restaurants/new')
      expect(current_path).to eq '/users/sign_in'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KF'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'KF'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      create_restaurant
      click_link 'Edit Sams Chicken'
      fill_in 'Name', with: 'Sams Kitchen'
      fill_in 'Description', with: 'Upmarket with a high chance of getting your wallet stolen'
      click_button 'Update Restaurant'
      click_link 'Sams Kitchen'
      expect(page).to have_content('Sams Kitchen')
      expect(page).to have_content('wallet stolen')
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'deleting restaurants' do

    scenario 'removes a restaurant when a user clicks a delete link' do
      create_restaurant
      click_link 'Delete Sams Chicken'
      expect(page).not_to have_content 'Sams Chicken'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
