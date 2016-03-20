class HomeworksController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    return unless current_user.participate_in?(params[:course_id])
    @homework = current_user.homeworks.build(lesson_id: params[:lesson_id])
  end

  def create
    Lesson.find_by_id(params[:lesson_id])

    @homework = current_user.homeworks.build(homework_params)
    @homework.lesson_id = params[:lesson_id]

    render :save_error unless @homework.save
  end

  def destroy
  end

  private

  def homework_params
    params.require(:homework).permit(:content)
  end
end
