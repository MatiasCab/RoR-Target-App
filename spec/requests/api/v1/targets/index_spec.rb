describe 'GET api/v1/targets', type: :request do
  let!(:user)               { create(:user) }
  let!(:user_targets)       { create_list(:target, 2, user:) }
  let!(:targets)            { create_list(:target, 4) }
  let(:first_user_target)   { user_targets.first }
  subject { get api_v1_targets_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns all user targets and only them' do
    subject
    expect(json[:targets].pluck(:title)).to match_array(user_targets.pluck(:title))
  end

  it 'returns targets in correct format' do
    subject
    expect(json[:targets].first[:id]).to eq(first_user_target.id)
    expect(json[:targets].first[:title]).to eq(first_user_target.title)
    expect(json[:targets].first[:radius]).to eq(first_user_target.radius)
    expect(json[:targets].first[:lat]).to eq(first_user_target.lat)
    expect(json[:targets].first[:lng]).to eq(first_user_target.lng)
    expect(json[:targets].first[:topic_id]).to eq(first_user_target.topic_id)
  end
end
