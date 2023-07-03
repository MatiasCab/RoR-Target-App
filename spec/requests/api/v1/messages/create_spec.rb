describe 'POST /api/v1/conversations/{id}/messages', type: :request do
    let!(:user)             { create(:user) }
    let(:first_user_target) { create(:target, user:)}
    include_context 'match target'
    let(:message)           { Message.last }
    let(:user_conversation) { user.conversations.first }
    let(:conversation_id)   { user_conversation.id }
    let(:failed_response)   { 400 }
    subject { post api_v1_conversation_messages_path(conversation_id:), params:, headers: auth_headers, as: :json }

    let(:content) { 'Test message content' }
    
    let(:params) do
        {
            message: {
                content:
            }
        }
    end

    context 'when the user have the conversation' do
        it 'returns a successful response' do
          subject
          expect(response).to be_successful
        end
  
        it 'creates the message' do
          expect { subject }.to change(user_conversation.messages, :count).from(0).to(1)
        end
  
        it 'returns the message' do
          subject
          expect(json[:message][:id]).to eq(message.id)
          expect(json[:message][:content]).to eq(content)
          expect(json[:message][:user_id]).to eq(user.id)
          expect(json[:message][:conversation_id]).to eq(conversation_id)
          expect(json[:message][:created_at]).to eq(message.created_at.iso8601(3))
        end
      end

      context 'when the user does not have the conversation' do
        let(:conversation_id) { user_conversation.id + 1}
        it 'does not create the message' do
            expect { subject }.not_to change { Message.count }
          end
    
          it 'does not return a successful response' do
            subject
            expect(response).to be_not_found
          end
      end

      context 'when the content is empty' do
        let(:content) { '' }
        it 'does not create the message' do
            expect { subject }.not_to change { Message.count }
          end
    
          it 'does not return a successful response' do
            subject
            expect(response.status).to eq(failed_response)
          end
      end
end