require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

current_time = Time.now
start_task_time = Time.new(current_time.year, current_time.month, current_time.day, 0, 0, 0)

start_task_time += 1.day if current_time > start_task_time
delay = start_task_time - current_time

Rails.application.load_tasks

scheduler.every '1d', first_in: delay do
  Rake::Task['target_manager:delete_old_targets'].invoke
  Rake::Task['target_manager:delete_old_targets'].reenable
end
