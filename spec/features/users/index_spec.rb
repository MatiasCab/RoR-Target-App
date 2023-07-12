describe 'Admin see users', type: :feature do
  let!(:admin)      { create(:admin_user) }
  let!(:users)      { create_list(:user, 3) }
  let(:first_user)  { users.first }
  subject { visit admin_users_path }

  before(:each) do
    sign_in(admin)
  end
  it 'show the users list' do
    subject
    aggregate_failures do
      expect(page).to have_content(first_user.email)
      expect(page).to have_content(first_user.first_name)
      expect(page).to have_content(first_user.last_name)
      expect(page).to have_content(first_user.username)
      expect(page).to have_content(first_user.sign_in_count)
      expect(page).to have_content(first_user.created_at.strftime('%B %d, %Y %H:%M'))
      expect(page).to have_content(first_user.updated_at.strftime('%B %d, %Y %H:%M'))
    end
  end
end
