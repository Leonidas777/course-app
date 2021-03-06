class ApprovedHomeworkNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', retry: true, failure: true

  def perform(homework_id)
    homework = Homework.find(homework_id)
    NotificationsMailer.approved_homework(homework).deliver_now
  end
end
