class LessonsController < ApplicationController
  before_action :check_permission
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_correct_url, only: [:show]
  before_action :require_admin, except: [:index, :show]
  

  # GET /videos
  # GET /videos.json
  def index
    if params[:category].blank?
      @lessons = Lesson.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @lessons = Lesson.where(category_id: @category_id).order("created_at DESC")  
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
     @lesson = Lesson.find(params[:id])
  end

  # GET /videos/new
  def new
       @lesson = Lesson.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lesson }
      else
        format.html { render action: 'new' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def redirect_to_correct_url
      # Redirect to the correct URL if the title of the video has since been changed
      if request.path != lesson_path(@lesson)
        return redirect_to @lesson, :status => :moved_permanently
      end
    end

    def check_permission
      if user_signed_in?
        # User needs to have paid for extra_access or be subscribed
        if !current_user.extra_access
          redirect_to new_charge_path, notice: "You need to be subscribed to access this content"
        end
      else
        # User needs to be signed in first
        redirect_to home_path, notice: "You must be logged in to access this section"
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
  def lesson_params
      params.require(:lesson).permit(:title, :description, :instructor, :url, :music, :category_id)
    end
end