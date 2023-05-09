describe 'GET api/v1/topics', type: :request do
    let!(:user)      { create(:user) }
    let!(:topics)    { create_list(:topic, 10) }
    subject { get api_v1_topics_path, headers: auth_headers, as: :json }

    it "returns a successful response" do
        subject
        expect(response).to be_successful
    end

    it "returns all topics" do
        subject
        expect(json[:topics].pluck(:name)).to match_array(topics.pluck(:name))
    end


    it "returns topics in correct format" do
        subject
        expect(json[:topics].first).to include_json(
            id: campaign.id,
            title: campaign.title,
            description: campaign.description,
            compensation_offer: campaign.compensation_offer
        )
    end
end