describe 'GET api/v1/topics', type: :request do
    let(:user)      { create(:user) }
    let(:topics)    { create_list(:topic, 10).as_json(only: [:name, :image]) }
    subject { get api_v1_topics_path, headers: auth_headers, as: :json }

    it "returns a successful response" do
        subject
        expect(response).to be_successful
    end

    it "returns topics in correct format" do
        subject
        expect(json[:topics]).to match_array(topics)
    end
end