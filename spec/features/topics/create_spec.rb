describe 'Admin create topic', type: :feature do
    let!(:admin)      { create(:admin_user) }
    let!(:topics)     { create_list(:topic, 3) }
    let(:first_topic) { topics.first }
    subject { visit new_admin_topic_path }
  
    before(:each) do
        sign_in(admin)
    end    
        it "create the topic" do
          subject
            fill_in 'Name', with: 'test'
            fill_in 'Image', with: 'test_image'
            click_button 'Create Topic'
            expect(page).to have_content('Topic was successfully created.')
          end
      end
    