describe 'Admin create topic', type: :feature do
  let!(:admin) { create(:admin_user) }
  let!(:topics)     { create_list(:topic, 3) }
  let(:first_topic) { topics.first }
  subject { visit new_admin_topic_path }

  before(:each) do
    sign_in(admin)
  end
  it 'have all the fields' do
    subject
    expect(page).to have_field('Name')
    expect(page).to have_field('Image')
  end
end
