class Users::HomeworksController < Users::BaseController
  before_filter :user_cannot_read_lesson

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

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
  end

  def user_cannot_read_lesson
    return if cannot? :read, lesson
  end
end
