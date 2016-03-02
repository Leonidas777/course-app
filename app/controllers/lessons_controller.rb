class LessonsController < ApplicationController
  PER_PAGE = 6

  def index
    # @courses = current_user.authored_courses.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
    @lessons = current_course.lessons.page(params[:page]).per(params[:per_page] || PER_PAGE)
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
    params.require(:lesson).permit(:title, :picture, :position, :description, :picture, :summary, :homework)
  end

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
  helper_method :current_course
end
