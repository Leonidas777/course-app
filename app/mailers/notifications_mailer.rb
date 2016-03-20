class NotificationsMailer < ApplicationMailer
  def approved_homework(homework)
    @homework = homework
    @recipient = homework.user
    
    mail(to: homework.user.email, subject: 'A homework was approved.')
  end

  def rejected_homework(homework)
    @homework = homework
    @recipient = homework.user
    
    mail(to: homework.user.email, subject: 'A homework was rejected.')
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
