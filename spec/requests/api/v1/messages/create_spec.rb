describe 'POST /api/v1/conversations/{id}/messages', type: :request do
    let(:user) { create(:user) }

    subject { post api_v1_conversation_messages_path, params:, headers: auth_headers, as: :json }
end