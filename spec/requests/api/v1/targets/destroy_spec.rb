describe 'DELETE api/v1/targets/{id}', type: :request do
  let!(:user)               { create(:user) }
  let!(:user_targets)       { create_list(:target, 3, user:) }
  let!(:other_targets)      { create_list(:target, 3) }
  let(:first_user_target)   { user_targets.first }
  let(:failed_response)     { 404 }
  let(:id)                  { first_user_target.id }
  subject { delete api_v1_target_path(id:), headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'deletes the target' do
    expect { subject }.to change(Target, :count).from(6).to(5)
  end

  it 'returns the deleted target in correct format' do
    subject
    expect(json[:target][:id]).to eq(first_user_target.id)
    expect(json[:target][:title]).to eq(first_user_target.title)
    expect(json[:target][:radius]).to eq(first_user_target.radius)
    expect(json[:target][:lat].round(12)).to eq(first_user_target.lat.round(12))
    expect(json[:target][:lng].round(12)).to eq(first_user_target.lng.round(12))
    expect(json[:target][:topic_id]).to eq(first_user_target.topic_id)
  end

  context 'when target do not belongs to current user' do
    let(:id) { other_targets.first.id }

    it 'does not delete a target' do
      expect { subject }.not_to change { Target.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response.status).to eq(failed_response)
    end
  end

  context 'when the id is not valid' do
    let(:id) { 'invalid_id' }

    it 'does not delete a target' do
      expect { subject }.not_to change { Target.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response.status).to eq(failed_response)
    end
  end
end
