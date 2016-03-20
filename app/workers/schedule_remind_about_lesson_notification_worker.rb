class ScheduleRemindAboutLessonNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'notifications', failure: true

  def perform(lesson_id, notification_time)
    lesson = Lesson.find(lesson_id)

    lesson.course.participants.pluck(:user_id).each do |user_id|
      RemindAboutLessonNotificationWorker.perform_async(lesson_id, user_id, notification_time)
    end
  end
end
