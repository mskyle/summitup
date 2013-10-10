module LoginHelper
  
  def login_user(user)
    visit root_path 
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"
  end

  
  
end
