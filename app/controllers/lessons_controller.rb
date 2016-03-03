class LessonsController < ApplicationController
  PER_PAGE = 6

  def index
    if params[:order] == 'desc'
      @lessons = current_course.lessons.desc_order
    else
      @lessons = current_course.lessons.asc_order
    end    
  end

  def show
    @lesson = Lesson.find(params[:lesson_id])
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

  def is_asc_order?
    params[:order] != 'desc'
  end

  helper_method :current_course
  helper_method :is_asc_order?  
end
