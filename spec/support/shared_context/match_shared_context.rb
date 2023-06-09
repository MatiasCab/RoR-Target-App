RSpec.shared_context 'match target' do
  before do
    title = 'match_test'
    radius = 27_384.4
    lat = match_target.lat
    lng = match_target.lng
    topic_id = match_target.topic_id
    params = {
      target: {
        title:,
        radius:,
        lat:,
        lng:,
        topic_id:
      }
    }

    post api_v1_targets_path, params:, headers: other_user.create_new_auth_token, as: :json
  end
end
