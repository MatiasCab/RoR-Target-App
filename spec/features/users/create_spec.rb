# describe 'Admin create user', type: :feature do
#     let!(:admin)      { create(:admin_user) }
#     let!(:users)      { create_list(:user, 3) }
#     let(:first_user)  { users.first }
#     subject { visit new_admin_user_path }
  
#     before(:each) do
#         sign_in(admin)
#     end    
#     it "create the user" do
#       subject
#       fill_in 'Email', with: 'test@example.com'
#       fill_in 'First name', with: 'test'
#       fill_in 'Last name', with: 'test'
#       fill_in 'Username', with: 'test'
#       fill_in 'Password*', with: 'password123'
#       fill_in 'Password confirmation', with: 'password123'
#       binding.pry
#       click_button 'Create User'  #Does not func
#       sign_in(admin)
      
#       new_user = User.last
#       binding.pry

#       expect(new_user.email).to eq('test@example.com')
#       expect(new_user.first_name).to eq('test')
#       expect(new_user.last_name).to eq('test')
#       expect(new_user.username).to eq('test')s
#       end
#   end
