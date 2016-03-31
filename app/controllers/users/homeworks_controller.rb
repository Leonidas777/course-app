class Users::HomeworksController < Users::BaseController
  def show
  end

  def new
    return unless current_user.participate_in?(params[:course_id])
    @homework = current_user.homeworks.build(lesson_id: params[:lesson_id])
  end

  def create
    lesson = Lesson.find(params[:lesson_id])

    @homework = current_user.homeworks.build(homework_params)
    @homework.lesson = lesson

    render :save_error unless @homework.save
  end

  def destroy
  end

  private

  def homework_params
    params.require(:homework).permit(:content)
  end

  def homework
    lesson = Lesson.find(params[:lesson_id])
    if can? :read, lesson
      @homework ||= Homework.find_by(lesson_id: params[:lesson_id], id: params[:id])
    end
  end
  helper_method :homework
end
