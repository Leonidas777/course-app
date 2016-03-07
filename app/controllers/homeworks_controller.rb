class HomeworksController < ApplicationController
  before_action :authenticate_user!

  def show
    @homework = Lesson.find(params[:homework_id])
  end

  def new
    @homework = current_user.homeworks.build
  end

  def create
    @homework = current_user.homeworks.build(homework_params)

    @homework.save!
  end

  def destroy

  end

  private

  def homework_params
    { lesson_id: params[:lesson_id], hw_text: params[:homework][:hw_text] }
  end
end
