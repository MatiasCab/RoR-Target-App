RSpec.describe "Admin Users Edit" do
    let!(:admin)    { create(:admin_user) }
    let!(:user)     { create(:user) }
    let!(:new_plan) { create(:plan) }
    subject { visit edit_admin_user_path(user.id) }
  
    before(:each) do
        sign_in(admin)
    end    
  
    it "displays the user's details in the form" do
      subject
      expect(page).to have_field("Email*", with: user.email)
      expect(page).to have_field("First name", with: user.first_name)
      expect(page).to have_field("Last name", with: user.last_name)
      expect(page).to have_field("Username", with: user.username)
      expect(page).to have_select("Plan*", selected: user.plan.name)
    end
  
    it "updates the user's details when submitting the form" do
      subject
      new_email = "new_email@example.com"
      new_first_name = "John"
      new_last_name = "Doe"
      new_username = "johndoe"
  
      fill_in "Email*", with: new_email
      fill_in "First name", with: new_first_name
      fill_in "Last name", with: new_last_name
      select new_plan.name, from: "Plan*"
      click_button "Update User"

      #expect(User.first.email).to eq(new_email)
      #expect(User.first.first_name).to eq(new_first_name)
      #expect(User.first.last_name).to eq(new_last_name)
      #expect(User.first.username).to eq(new_username)
      #expect(User.first.plan).to eq(new_plan) 
    end
  end
  