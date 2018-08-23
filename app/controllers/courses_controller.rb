class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :users_only

  # GET /courses
  # GET /courses.json
  def index
    #get courses to show, subjects for search params
    @courses = Course.all
    @subjects = Subject.all.order(:name)

    #get user and courses to whether to display enroll/unenroll
    @user = current_user
    @enrolled_courses = @user.courses
  end

  def results
    #get courses to show, subjects for search params
    @courses = Course.search(params)
    @subjects = Subject.all.order(:name)

    #get user and courses to whether to display enroll/unenroll
    @user = current_user
    @enrolled_courses = @user.courses

    respond_to do |format|
      format.js
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @users = Course.find(@course.id).users
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /enrollment
  def create_enrollment
    @current_user = current_user
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @current_user}
      else
        format.html { redirect_to :index }
      end
    end
  end

  #DELETE /enrollments/1
  def destroy_enrollment
    @enrollment = Enrollment.find_by(course_id: params[:course_id],user_id: params[:user_id])
    @enrollment.destroy

    @user = User.find(params[:user_id])
    @enrolled_courses = @user.courses

    respond_to do |format|
      format.js
    end
  end

  #DELETE /enrollments/1
  def destroy_enrollment_reg
    @enrollment = Enrollment.find_by(course_id: params[:course_id],user_id: params[:user_id])
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to @current_user}
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :code, :description)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:course_id, :user_id)
    end
end
