describe 'Admin create user', type: :feature do
  let!(:admin)      { create(:admin_user) }
  let!(:users)      { create_list(:user, 3) }
  let(:first_user)  { users.first }
  subject { visit new_admin_user_path }

  before(:each) do
    sign_in(admin)
  end
  it 'have all the fields' do
    subject
    expect(page).to have_field('Email')
    expect(page).to have_field('First name')
    expect(page).to have_field('Last name')
    expect(page).to have_field('Username')
    expect(page).to have_field('Password')
    expect(page).to have_field('Password confirmation')
  end
end
