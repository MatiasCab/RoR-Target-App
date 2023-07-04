describe 'GET /api/v1/conversations/{id}/messages', type: :request do
  let!(:user) { create(:user) }
  let(:first_user_target) { create(:target, user:) }
  include_context 'match target'
  let(:user_conversation) { user.conversations.first }
  let!(:messages)         { create_list(:message, 25, conversation: user_conversation, user:) }
  let(:first_message)     { messages.first }
  let(:conversation_id)   { user_conversation.id }
  let(:pagination_limit)  { Message::PAGINATION_LIMIT }
  subject do
    get api_v1_conversation_messages_path(conversation_id:), params:, headers: auth_headers,
                                                             as: :json
  end

  let(:page) { 1 }
  let(:params) do
    {
      page:
    }
  end

  context 'when a page is not specificated' do
    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns first message page' do
      subject
      expect(json[:messages].pluck(:id)).to match_array(messages.take(pagination_limit).pluck(:id))
    end

    it 'returns messages in correct format' do
      subject
      expect(json[:messages].first[:id]).to eq(first_message.id)
      expect(json[:messages].first[:content]).to eq(first_message.content)
      expect(json[:messages].first[:user_id]).to eq(first_message.user_id)
      expect(json[:messages].first[:conversation_id]).to eq(first_message.conversation_id)
      expect(json[:messages].first[:created_at]).to eq(first_message.created_at.iso8601(3))
    end
  end

  context 'when a page is specificated' do
    let(:page) { 2 }
    let(:messages_second_page)  { messages[pagination_limit, pagination_limit] }
    let(:first_message)         { messages_second_page.first }

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns specificated message page' do
      subject
      expect(json[:messages].pluck(:id)).to match_array(messages_second_page.pluck(:id))
    end

    it 'returns messages in correct format' do
      subject
      expect(json[:messages].first[:id]).to eq(first_message.id)
      expect(json[:messages].first[:content]).to eq(first_message.content)
      expect(json[:messages].first[:user_id]).to eq(first_message.user_id)
      expect(json[:messages].first[:conversation_id]).to eq(first_message.conversation_id)
      expect(json[:messages].first[:created_at]).to eq(first_message.created_at.iso8601(3))
    end
  end
end
