class Users::HomeworksHandlingController < Users::BaseController
  def create
    homework.approve
  end

  def destroy
    homework.reject
  end

  def homework
    lesson = Lesson.find(params[:lesson_id])
    if can? :read, lesson
      @homework ||= Homework.find_by(lesson_id: params[:lesson_id], id: params[:id])
    end
  end
end
