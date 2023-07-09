describe 'Admin see topics', type: :feature do
  let!(:admin) { create(:admin_user) }
  let!(:topics)      { create_list(:topic, 3) }
  let(:first_topic)  { topics.first }
  subject { visit admin_topics_path }

  before(:each) do
    sign_in(admin)
  end

  it 'show the topics list' do
    subject
    aggregate_failures do
      expect(page).to have_content(first_topic.name)
      expect(page).to have_content(first_topic.image)
    end
  end
end
