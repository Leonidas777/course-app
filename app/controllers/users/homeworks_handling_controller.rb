class Users::HomeworksHandlingController < Users::BaseController
  before_filter :user_cannot_read_lesson

  def create
    if homework.approve!
      ApprovedHomeworkNotificationWorker.perform_async(homework.id)
    end
  end

  def destroy
    if homework.reject!
      RejectedHomeworkNotificationWorker.perform_async(homework.id)
    end
  end

  def homework
    @homework ||= Homework.find(params[:id])
  end
  helper_method :homework

  def user_cannot_read_lesson
    return if cannot? :read, homework.lesson
  end
end
