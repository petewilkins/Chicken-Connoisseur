def sign_up(email:'roi@makers.com',
            password: 'likemybeard',
            password_confirmation: 'likemybeard')
  visit('/')
  click_link "Sign up"
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password_confirmation
  click_button "Sign up"
end

def create_restaurant
  sign_up
  user = User.first
  user.restaurants.create(name: "Sams Chicken", description: "Not mexican")
  visit('/')
end
