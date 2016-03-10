class HomeworksController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def new
    return unless current_user.participate_in?(params[:course_id])
    @homework = current_user.homeworks.build
  end

  def create
    @homework = current_user.homeworks.where(lesson_id: params[:lesson_id]).first_or_create.update(homework_params)
  end

  def destroy
  end

  private

  def homework_params
    { lesson_id: params[:lesson_id], hw_text: params[:homework][:hw_text] }
  end
end
