describe 'Admin create user', type: :feature do
    let!(:admin)      { create(:admin_user) }
    let!(:users)      { create_list(:user, 3) }
    let(:first_user)  { users.first }
    subject { visit new_admin_user_path }
  
    before(:each) do
        sign_in(admin)
    end    
    it "have all the fields" do
    subject
    expect(page).to have_field('Email')
    expect(page).to have_field('First name')
    expect(page).to have_field('Last name')
    expect(page).to have_field('Username')
    expect(page).to have_field('Password')
    expect(page).to have_field('Password confirmation')
  end
      # it "create the user" do
      #     subject
      #     fill_in 'Email', with: 'test@example.com'
      #     fill_in 'First name', with: 'test'
      #     fill_in 'Last name', with: 'test'
      #     fill_in 'Username', with: 'test'
      #     fill_in 'Password*', with: 'password123'
      #     fill_in 'Password confirmation', with: 'password123'
      #     click_button 'Create User'  #Does not func
      #     new_user = User.last

      #     expect(new_user.email).to eq('test@example.com')
      #     expect(new_user.first_name).to eq('test')
      #     expect(new_user.last_name).to eq('test')
      #     expect(new_user.username).to eq('test')s
      #     end
  end


