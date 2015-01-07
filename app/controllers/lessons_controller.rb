class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  

  def index
    @lessons = Lesson.all
  end

  def show
     @lesson = Lesson.find(params[:id])
  end

  def new
    authorize! :new, @user, :message => 'Not authorized as an administrator.'
    @lesson = Lesson.new
  end

  def edit
  end

  def create
    authorize! :create, @lesson, :message => 'Not authorized as an administrator.'
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end

    def update
    if  @lesson.update(lesson_params)
      redirect_to @lesson, notice: 'Picture was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @lesson.destroy
    redirect_to lessons_url
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
    def authenticate_user
      redirect_to pages_home_path, notice: "You must be signed in to view that page" unless user_signed_in?
    end

    def lesson_params
      params.require(:lesson).permit(:title, :description, :instructor, :url, :music)
    end
end
