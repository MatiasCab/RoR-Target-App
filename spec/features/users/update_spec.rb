RSpec.describe 'Admin Users Edit' do
  let!(:admin)    { create(:admin_user) }
  let!(:user)     { create(:user) }
  let!(:new_plan) { create(:plan) }
  subject { visit edit_admin_user_path(user.id) }

  before(:each) do
    sign_in(admin)
  end

  it "displays the user's details in the form" do
    subject
    expect(page).to have_field('Email*', with: user.email)
    expect(page).to have_field('First name', with: user.first_name)
    expect(page).to have_field('Last name', with: user.last_name)
    expect(page).to have_field('Username', with: user.username)
    expect(page).to have_select('Plan*', selected: user.plan.name)
  end
end
