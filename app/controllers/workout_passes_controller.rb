class WorkoutPassesController < ApplicationController
  # GET /workout_passes
  # GET /workout_passes.json
  def index
    @workout_passes = WorkoutPass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workout_passes }
    end
  end

  # GET /workout_passes/1
  # GET /workout_passes/1.json
  def show
    @workout_pass = WorkoutPass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workout_pass }
    end
  end

  # GET /workout_passes/new
  # GET /workout_passes/new.json
  def new
    @workout_pass = WorkoutPass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workout_pass }
    end
  end

  # GET /workout_passes/1/edit
  def edit
    @workout_pass = WorkoutPass.find(params[:id])
  end

  # POST /workout_passes
  # POST /workout_passes.json
  def create
    @workout_pass = WorkoutPass.new(params[:workout_pass])

    respond_to do |format|
      if @workout_pass.save
        format.html { redirect_to @workout_pass, notice: 'Workout pass was successfully created.' }
        format.json { render json: @workout_pass, status: :created, location: @workout_pass }
      else
        format.html { render action: "new" }
        format.json { render json: @workout_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workout_passes/1
  # PUT /workout_passes/1.json
  def update
    @workout_pass = WorkoutPass.find(params[:id])

    respond_to do |format|
      if @workout_pass.update_attributes(params[:workout_pass])
        format.html { redirect_to @workout_pass, notice: 'Workout pass was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workout_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_passes/1
  # DELETE /workout_passes/1.json
  def destroy
    @workout_pass = WorkoutPass.find(params[:id])
    @workout_pass.destroy

    respond_to do |format|
      format.html { redirect_to workout_passes_url }
      format.json { head :no_content }
    end
  end
end
