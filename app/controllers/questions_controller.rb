class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(:workout_id => params[:workout_id]).order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @questions.as_json(:include => :answers) }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    workout = Workout.find params[:workout_id]
    result  = Question.create(workout, { 
        :body => params[:body], 
        :answer_type => params[:answer_type] }, 
        params[:answers].values
      )

    @question = result[:question]

    respond_to do |format|
      unless @question.persisted?
        format.json { render :json => @question.errors.full_messages, :status => :unprocessable_entity }
      else
        format.json { render :json => @question.as_json({:include => :answers}) }
      end
      
    end

  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.update(params[:id], { 
        :body => params[:body], 
        :answer_type => params[:answer_type] }, 
        params[:answers].values
      )

    respond_to do |format|
      format.json { render :json => @question.as_json({:include => :answers}) }

      # if @question.update_attributes(params[:question])
      #   format.html { redirect_to @question, :notice => 'Question was successfully updated.' }
      #   format.json { head :no_content }
      # else
      #   format.html { render :action => "edit" }
      #   format.json { render :json => @question.errors, :status => :unprocessable_entity }
      # end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
end
