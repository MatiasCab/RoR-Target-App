describe 'DELETE api/v1/targets/{id}', type: :request do
  let!(:user)               { create(:user) }
  let!(:user_targets)       { create_list(:target, 2, user:) }
  let!(:other_targets)      { create_list(:target, 2) }
  let(:first_user_target)   { user_targets.first }
  let(:id)                  { first_user_target.id }
  subject { delete api_v1_target_path(id:), headers: auth_headers, as:l :json }

  context 'when the target did not match' do
    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'deletes the target' do
      expect { subject }.to change(user.targets, :count).by(-1)
    end

    it 'does not delete a conversation' do
      expect { subject }.not_to change { Conversation.count }
    end

    it 'returns the deleted target in correct format' do
      subject
      expect(json[:target][:id]).to eq(first_user_target.id)
      expect(json[:target][:title]).to eq(first_user_target.title)
      expect(json[:target][:radius]).to eq(first_user_target.radius)
      expect(json[:target][:matched]).to eq(false)
      expect(json[:target][:lat].round(12)).to eq(first_user_target.lat.round(12))
      expect(json[:target][:lng].round(12)).to eq(first_user_target.lng.round(12))
      expect(json[:target][:topic_id]).to eq(first_user_target.topic_id)
      expect(json[:target][:matched_user]).to eq(nil)
    end
  end

  context 'when target do not belongs to current user' do
    let(:id) { other_targets.first.id }

    it 'does not delete a target' do
      expect { subject }.not_to change { Target.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response).to be_not_found
    end
  end

  context 'when the id is not valid' do
    let(:id) { 'invalid_id' }

    it 'does not delete a target' do
      expect { subject }.not_to change { Target.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response).to be_not_found
    end
  end

  context 'when the target is matched' do
    let!(:other_user)  { create(:user) }
    let(:match_target) { first_user_target }

    include_context 'match target'

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'deletes the target' do
      expect { subject }.to change(user.targets, :count).by(-1)
    end

    it 'returns the deleted target in correct format' do
      subject
      expect(json[:target][:id]).to eq(first_user_target.id)
      expect(json[:target][:title]).to eq(first_user_target.title)
      expect(json[:target][:radius]).to eq(first_user_target.radius)
      expect(json[:target][:matched]).to eq(true)
      expect(json[:target][:lat].round(12)).to eq(first_user_target.lat.round(12))
      expect(json[:target][:lng].round(12)).to eq(first_user_target.lng.round(12))
      expect(json[:target][:topic_id]).to eq(first_user_target.topic_id)
    end

    it 'deletes the conversation of the matched target' do
      expect { subject }.to change(user.conversations, :count).by(-1)
    end

    it 'checks if other target now is available for matching again' do
      subject
      expect(other_user.targets.first.matched).to eq(false)
    end
  end
end
