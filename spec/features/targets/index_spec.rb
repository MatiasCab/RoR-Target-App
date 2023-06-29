describe 'GET /api/v1/conversations/{id}/messages', type: :feature do
  let!(:admin)   { create(:admin_user) }
  let!(:targets)      { create_list(:target, 3) }
  subject { visit admin_targets_path }

  before(:each) do
      sign_in(admin)
  end    

    it "does not display delete action" do
        subject
        expect(page).to have_no_link("Delete")
        expect(page).to have_no_button("Delete")
    end

    it "does not display edit action" do
        subject
        expect(page).to have_no_link("Edit")
        expect(page).to have_no_button("Edit")
    end
  
      it "show the targets list" do
        subject
        targets.each do |target|
          expect(page).to have_content(target.title)
          expect(page).to have_content(target.radius)
          expect(page).to have_content(target.lat)
          expect(page).to have_content(target.lng)
          expect(page).to have_content(target.matched ? "Yes" : "No") #FIXME
          expect(page).to have_content(target.user.first_name)
          expect(page).to have_content(target.topic.name)
          expect(page).to have_content(target.created_at.strftime('%B %d, %Y %H:%M'))
        end
    end
  end
  