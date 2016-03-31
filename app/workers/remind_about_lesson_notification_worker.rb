class RemindAboutLessonNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', retry: true, failure: true

  def perform(lesson_id, user_id, notification_time)
    lesson = Lesson.find(lesson_id)
    user = User.find(user_id)

    parsed_notification_time = Time.zone.parse(notification_time)
    NotificationsMailer.delay_until(parsed_notification_time).remind_about_lesson(lesson, user)
  end
end
