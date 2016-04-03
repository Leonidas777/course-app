class Users::HomeworksHandlingController < Users::BaseController
  before_filter :user_cannot_read_lesson

  def create
    homework.approve!
  end

  def destroy
    homework.reject!
  end

  def homework
    @homework ||= Homework.find(params[:id])
  end
  helper_method :homework

  def user_cannot_read_lesson
    return if cannot? :read, homework.lesson
  end
end
