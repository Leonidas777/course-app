class Users::CoursesController < Users::BaseController
  PER_PAGE = 3

  before_action :find_course, only: [:edit, :update, :destroy]
  before_filter :user_cannot_create_course, only: [:new, :create]

  def index
    @courses = current_user.authored_courses.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def new
    @course = current_user.authored_courses.build
  end

  def create
    @course = current_user.authored_courses.build(course_params)
    if @course.save
      redirect_after_creating 'The course was successfully added.'
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to users_courses_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @course.destroy

    redirect_to users_courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :picture)
  end

  def find_course
    @course = current_user.authored_courses.find(params[:id])
  end

  def user_cannot_create_course
    if cannot? :create, :course
      return redirect_after_creating 'Only trainer can add a new course.'
    end
  end

  def redirect_after_creating(message)
    flash['new_course'] = message
    redirect_to users_courses_path
  end
end
