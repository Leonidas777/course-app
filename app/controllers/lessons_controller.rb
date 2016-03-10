class LessonsController < ApplicationController
  PER_PAGE = 6

  def index
    if params[:order] == 'desc'
      if user_signed_in? && author?
        @lessons = current_course.lessons.desc_order
      else
        @lessons = current_course.lessons.where(visible: true).desc_order
      end
    elsif user_signed_in? && author?
        @lessons = current_course.lessons.asc_order
      else
        @lessons = current_course.lessons.where(visible: true).asc_order
      end
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = current_course.lessons.build
  end

  def create
    @lesson = current_course.lessons.build(lesson_params)

    if @lesson.save!
      redirect_to course_lessons_path
    else
      render :new
    end
  end

  def destroy
    @lesson.destroy
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :picture, :position, :description, :picture, :summary, :homework, :order)
  end

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def asc_order?
    params[:order] != 'desc'
  end

  def author?
    current_user.id == current_course.user.id
  end

  helper_method :current_course, :asc_order?, :author?
end
