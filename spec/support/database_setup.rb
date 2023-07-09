RSpec.configure do |config|
    config.before(:suite) do
        Plan.find_or_create_by(id: 1) do |plan|
            FactoryBot.create(:plan, id: 1, target_limit: 3)
        end
    end
end