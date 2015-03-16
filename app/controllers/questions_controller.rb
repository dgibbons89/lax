class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_permission, only: [:new, :create]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.order('created_at DESC')
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
   @answers = Answer.where(question_id: @question.id).order("created_at DESC")
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    

    respond_to do |format|
      if @question.save
        UserMailer.question_notification(current_user.name, @question.subject, @question.post).deliver
        format.html { redirect_to @question, notice: 'Question was successfully created. Youll get an answer soon' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
  private
    def set_question
      @question = Question.find(params[:id])
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
    def check_user
      unless (@question.user == current_user) || (current_user.admin?)
        redirect_to root_url, alert: "Sorry, this review belongs to someone else"
      end
    end  

    def question_params
      params.require(:question).permit(:subject, :post)
    end
end

