class NotificationsMailer < ApplicationMailer
  def approved_homework(homework)
    @homework = homework
    @recipient = homework.user

    mail(to: homework.user.email, subject: 'Homework was approved.')
  end

  def rejected_homework(homework)
    @homework = homework
    @recipient = homework.user

    mail(to: homework.user.email, subject: 'Homework was rejected.')
  end

  def homework_pending(homework)
    @homework = homework
    @recipient = homework.user

    mail(to: homework.user.email, subject: 'Homework is pending.')
  end

  def loaded_material(lesson, recipient)
    @lesson = lesson
    @recipient = recipient

    mail(to: recipient.email, subject: 'A new material was loaded.')
  end

  def remind_about_lesson(lesson, recipient)
    @lesson = lesson
    @recipient = recipient

    mail(to: recipient.email, subject: 'A lesson is going to start soon.')
  end
end
