RSpec.shared_context 'match target' do
  let!(:other_user)     { create(:user) }
  let!(:matched_target) do
    create(:target,
           user: other_user,
           lat: first_user_target.lat,
           lng: first_user_target.lng,
           topic: first_user_target.topic,
           matched: true)
  end
  let!(:conversation) { create(:conversation, topic: first_user_target.topic) }
  let!(:user_conversation_instance) do
    create(:match_users_conversation, user:, conversation:, target: first_user_target)
  end
  let!(:other_user_conversation_instance) do
    create(:match_users_conversation, user: other_user, conversation:, target: matched_target)
  end

  before do
    first_user_target.update(matched: true)
  end
end
