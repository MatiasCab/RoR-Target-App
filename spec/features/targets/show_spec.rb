describe 'Admin view target', type: :feature do
  let!(:admin)        { create(:admin_user) }
  let!(:targets)      { create_list(:target, 3) }
  let(:first_target)  { targets.first }
  subject { visit admin_target_path(first_target.id) }

  before(:each) do
    sign_in(admin)
  end

  it 'does not display delete action' do
    subject
    expect(page).to have_no_link('Delete')
    expect(page).to have_no_button('Delete')
  end

  it 'does not display edit action' do
    subject
    expect(page).to have_no_link('Edit')
    expect(page).to have_no_button('Edit')
  end

  it 'show the target' do
    subject
    aggregate_failures do
      expect(page).to have_content(first_target.title)
      expect(page).to have_content(first_target.radius)
      expect(page).to have_content(first_target.lat)
      expect(page).to have_content(first_target.lng)
      expect(page).to have_content(first_target.matched ? 'Yes' : 'No')
      expect(page).to have_content(first_target.user.first_name)
      expect(page).to have_content(first_target.topic.name)
      expect(page).to have_content(first_target.created_at.strftime('%B %d, %Y %H:%M'))
      expect(page).to have_content(first_target.updated_at.strftime('%B %d, %Y %H:%M'))
    end
  end
end
