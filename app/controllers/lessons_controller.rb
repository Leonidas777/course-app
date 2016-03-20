class LessonsController < ApplicationController
  PER_PAGE = 6

  def index
    return desc_order_lessons if params[:order] == 'desc'
    asc_order_lessons
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
    params.require(:lesson).permit(:title, :picture, :position, :description, :picture, :summary, :homework, :order, :meeting_datetime)
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

  def desc_order_lessons
    if user_signed_in? && author?
      return @lessons = current_course.lessons.desc_order.one_page(params[:page], params[:per_page])
    end
    @lessons = current_course.lessons.desc_order.one_page(params[:page], params[:per_page], true)
  end

  def asc_order_lessons
    if user_signed_in? && author?
      return @lessons = current_course.lessons.asc_order.one_page(params[:page], params[:per_page]) if user_signed_in? && author?
    end
    @lessons = current_course.lessons.asc_order.one_page(params[:page], params[:per_page], true)
  end

  helper_method :current_course, :asc_order?, :author?
end
