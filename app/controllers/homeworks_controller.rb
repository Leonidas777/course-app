class HomeworksController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    return unless current_user.participate_in?(params[:course_id])
    @homework = current_user.homeworks.build(lesson_id: params[:lesson_id])
  end

  def create
    redirect_for_inexisted_lesson if Lesson.find_by_id(params[:lesson_id]).nil?

    @homework = current_user.homeworks.build(homework_params)
    @homework.lesson_id = params[:lesson_id]

    render :save_error unless @homework.save
  end

  def destroy
  end

  private

  def redirect_for_inexisted_lesson
    flash[:create_err] = "The given lesson_id doesn't exist."
    flash.keep(:create_err)
    render js: "window.location = #{courses_path.to_json}"
  end

  def homework_params
    params.require(:homework).permit(:content)
  end
end
