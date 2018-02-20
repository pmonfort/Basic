module UserHelper
  def login(email, password)
    visit login_url

    within('form.session') do
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_button 'Submit'
    end
  end
end
