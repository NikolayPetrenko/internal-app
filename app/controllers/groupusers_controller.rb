class GroupusersController < ApplicationController
  # GET /groupusers
  # GET /groupusers.json
  def index
    @groupusers = Group.find(params[:group_id]).users

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groupusers }
    end
  end

  # GET /groupusers/1
  # GET /groupusers/1.json
  def show
    @groupuser = Groupuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @groupuser }
    end
  end

  # GET /groupusers/new
  # GET /groupusers/new.json
  def new
    @groupuser = Groupuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @groupuser }
    end
  end

  # GET /groupusers/1/edit
  def edit
    @groupuser = Groupuser.find(params[:id])
  end

  # POST /groupusers
  # POST /groupusers.json
  def create
    group = Group.find(params[:group_id])
    @user = User.find params[:user_id]

    logger.debug group.users.exists?(@user).inspect
    unless group.users.exists? @user
      group.users << @user
    end

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
    # @groupuser = Groupuser.new(params[:groupuser])

    # respond_to do |format|
    #   if @groupuser.save
    #     format.html { redirect_to @groupuser, notice: 'Groupuser was successfully created.' }
    #     format.json { render json: @groupuser, status: :created, location: @groupuser }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @groupuser.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /groupusers/1
  # PUT /groupusers/1.json
  def update
    @groupuser = Groupuser.find(params[:id])

    respond_to do |format|
      if @groupuser.update_attributes(params[:groupuser])
        format.html { redirect_to @groupuser, notice: 'Groupuser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @groupuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groupusers/1
  # DELETE /groupusers/1.json
  def destroy
    @groupuser = Groupuser.find(params[:id])
    @groupuser.destroy

    respond_to do |format|
      format.html { redirect_to groupusers_url }
      format.json { head :no_content }
    end
  end
end
