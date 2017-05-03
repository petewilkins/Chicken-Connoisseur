require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: "KF")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    user = User.create(email:"roi@ma.com", password:'1234567')
    user.restaurants.create(name: "KFC")
    restaurant = user.restaurants.new(name: "KFC")
    expect(restaurant).to have(1).error_on(:name)
  end

  it { should belong_to(:user) }

end
