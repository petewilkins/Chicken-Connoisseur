require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Sams Chicken')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Sams Chicken'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Sams Chicken'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Sams Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'Sams Chicken', description: 'Bones with a high chance of getting your phone stolen', id: 1 }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Sams Chicken'
      fill_in 'Name', with: 'Sams Kitchen'
      fill_in 'Description', with: 'Upmarket with a high chance of getting your wallet stolen'
      click_button 'Update Restaurant'
      click_link 'Sams Kitchen'
      expect(page).to have_content('Sams Kitchen')
      expect(page).to have_content('wallet stolen')
      expect(current_path).to eq '/restaurants/1'
    end
  end
end
