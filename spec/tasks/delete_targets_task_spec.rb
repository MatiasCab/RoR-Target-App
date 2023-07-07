describe 'rake target_manager:delete_old_targets', type: :task do
  let!(:old_targets) { create_list(:target, 3, created_at: rand(1.year.ago..1.week.ago)) }
  let!(:new_target) { create(:target) }
  subject { Rake::Task['target_manager:delete_old_targets'] }

  before :all do
    Rails.application.load_tasks
  end

  it 'deletes all old targets' do
    expect { subject.invoke }.to change { Target.count }.by(-3)
    expect(Target.first.id).to eq(new_target.id)
  end
end
