class NotificationsMailer < ApplicationMailer
  def approved_homework(homework, recipient)
    @homework = homework
    @recipient = recipient
    
    mail(to: recipient.email, subject: 'A homework was approved.')
  end

  def rejected_homework(homework, recipient)
    @homework = homework
    @recipient = recipient
    
    mail(to: recipient.email, subject: 'A homework was rejected.')
  end

  def loaded_material(lesson, recipient)
    @lesson = lesson
    @recipient = recipient
    
    mail(to: recipient.email, subject: 'A new material was loaded.')
  end
end
