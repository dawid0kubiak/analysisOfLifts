class LiftTypesController < ApplicationController
  before_action :set_lift_type, only: %i[show edit update destroy]
  before_action :set_lifts, only: %i[new edit]

  # GET /lift_types
  # GET /lift_types.json
  def index
    @lift_types = LiftType.where(user_id: current_user.id).or(LiftType.where(user_id: nil))
  end

  # GET /lift_types/1
  # GET /lift_types/1.json
  def show;
  end

  # GET /lift_types/new
  def new
    @lift_type = LiftType.new
  end

  # GET /lift_types/1/edit
  def edit;
  end

  # POST /lift_types
  # POST /lift_types.json
  def create
    @lift_type = LiftType.new(lift_type_params)
    @lift_type.user_id = current_user.id
    respond_to do |format|
      if @lift_type.save
        format.html {redirect_to lift_types_path, notice: 'Lift type was successfully created.'}
        format.json {render :show, status: :created, location: @lift_type}
      else
        format.html {render :new}
        format.json {render json: @lift_type.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /lift_types/1
  # PATCH/PUT /lift_types/1.json
  def update
    respond_to do |format|
      if @lift_type.update(lift_type_params)
        format.html {redirect_to lift_types_path, notice: 'Lift type was successfully updated.'}
        format.json {render :show, status: :ok, location: @lift_type}
      else
        format.html {render :edit}
        format.json {render json: @lift_type.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /lift_types/1
  # DELETE /lift_types/1.json
  def destroy
    @lift_type.destroy
    respond_to do |format|
      format.html {redirect_to lift_types_url, notice: 'Lift type was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_lift_type
    @lift_type = LiftType.find(params[:id])
    redirect_to lift_types_path unless @lift_type.user_id
  end

  def set_lifts
    @lifts = Lift.where(lift_type_id: -1)
  end

  def lift_type_params
    params.require(:lift_type).permit(:condition, :name)
  end
end
