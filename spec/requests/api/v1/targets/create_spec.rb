describe 'POST api/v1/targets', type: :request do
    let(:user)             { create(:user) }
    let(:target)            { Target.last }
    let(:failed_response) { 422 }

    describe 'POST create' do
        subject { post api_v1_targets_path, params:, headers: auth_headers,  as: :json }

        let(:title)           { 'test' }
        let(:radius)          { 27384.4 }
        let(:lat)             { -94.5566 }
        let(:lng)             { -94.5566 }
        let(:topic_id)        { 2 }
    
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

        it 'returns a successful response' do
            subject
            expect(response).to have_http_status(:success)
        end

        it 'creates the target' do
            expect { subject }.to change(Target, :count).by(1)
        end
    
        it 'returns the target' do
            subject
    
            expect(json[:target][:title]).to eq(target.title)
            expect(json[:target][:radius]).to eq(target.radius)
            expect(json[:target][:lat]).to eq(target.lat)
            expect(json[:target][:lng]).to eq(target.lng)
            expect(json[:target][:topic_id]).to eq(target.topic_id)
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
            let(:lat)           { 'invalid_lat' }
            let(:lng)           { 'invalid_lng' }
    
            it 'does not create a target' do
                expect { subject }.not_to change { Target.count }
            end
    
            it 'does not return a successful response' do
                subject
                expect(response.status).to eq(failed_response)
            end
        end
    
        context 'when radius is incorrect' do
            let(:radius)           { 'invalid_radius' }
    
            it 'does not create a target' do
                expect { subject }.not_to change { Target.count }
            end
    
            it 'does not return a successful response' do
                subject
                expect(response.status).to eq(failed_response)
            end
        end
    end
end