describe 'GET api/v1/conversations', type: :request do
  let!(:user)                   { create(:user) }
  let!(:user_targets)           { create_list(:target, 2, user:) }
  let!(:other_user)             { create(:user)}
  let(:match_target)            { user_targets.first }
  let(:first_user_conversation) { user.conversations.first }
  subject { get api_v1_conversations_path, headers: auth_headers, as: :json }

  include_context 'match target'

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns all user conversations and only them' do
    subject
    expect(json[:conversations].pluck(:id)).to match_array(user.conversations.pluck(:id))
  end

  it 'returns conversations in correct format' do
    subject
    expect(json[:conversations].first[:id]).to eq(first_user_conversation.id)
    expect(json[:conversations].first[:topic_id]).to eq(first_user_conversation.topic_id)
  end
end
