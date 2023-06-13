describe 'POST api/v1/targets', type: :request do
  let(:user)            { create(:user) }
  let(:topic)           { create(:topic) }
  let(:target)          { Target.last }
  let(:failed_response) { 400 }

  describe 'POST create' do
    subject { post api_v1_targets_path, params:, headers: auth_headers, as: :json }

    let(:title)           { 'test' }
    let(:radius)          { 27_384.4 }
    let(:lat)             { -94.5566 }
    let(:lng)             { -94.5566 }
    let(:topic_id)        { topic.id }

    let(:params) do
      {
        target: {
          title:,
          radius:,
          lat:,
          lng:,
          topic_id:
        }
      }
    end

    context 'when the user has not match' do
      it 'returns a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'creates the target' do
        expect { subject }.to change(user.targets, :count).from(0).to(1)
      end

      it 'returns the target' do
        subject
        expect(json[:target][:id]).to eq(target.id)
        expect(json[:target][:title]).to eq(target.title)
        expect(json[:target][:radius]).to eq(target.radius)
        expect(json[:target][:matched]).to be_falsey
        expect(json[:target][:lat].round(12)).to eq(target.lat.round(12))
        expect(json[:target][:lng].round(12)).to eq(target.lng.round(12))
        expect(json[:target][:topic_id]).to eq(target.topic_id)
        expect(json[:target][:matched_user]).to eq(nil)
      end
    end

    context 'when the user has reached the maximum number of targets' do
      let!(:user_targets)  { create_list(:target, 3, user:) }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the topic id is not correct' do
      let(:topic_id) { 'invalid_topic_id' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the latitude or longitude is incorrect' do
      let(:lat) { 'invalid_lat' }
      let(:lng) { 'invalid_lng' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when radius is incorrect' do
      let(:radius) { 'invalid_radius' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the user make a match' do
      let!(:other_user)        { create(:user) }
      let!(:other_user_target) { create(:target, user: other_user, topic_id:, lat:, lng:) }

      it 'returns a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'creates the target' do
        expect { subject }.to change(user.targets, :count).from(0).to(1)
      end

      it 'returns the matched target' do
        subject
        expect(json[:target][:id]).to eq(target.id)
        expect(json[:target][:title]).to eq(target.title)
        expect(json[:target][:radius]).to eq(target.radius)
        expect(json[:target][:matched]).to be_truthy
        expect(json[:target][:lat].round(12)).to eq(target.lat.round(12))
        expect(json[:target][:lng].round(12)).to eq(target.lng.round(12))
        expect(json[:target][:topic_id]).to eq(target.topic_id)
        expect(json[:target][:matched_user]).to eq(other_user.full_name)
      end
    end
  end
end
