namespace :target_manager do
  desc 'Delete unmatched targets'
  task delete_old_targets: :environment do
    Rails.logger.info 'Initializing delete unmatched targets task'

    delay = ENV.fetch('TARGET_DELETION_TIME', '1').to_i

    Target.where('matched = FALSE AND created_at <= ?', delay.week.ago).destroy_all

    Rails.logger.info 'Completed delete unmatched targets task'
  end
end
