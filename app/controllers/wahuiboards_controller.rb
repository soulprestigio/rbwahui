class WahuiboardsController < ApplicationController
  before_action :set_wahuiboard, only: [:show, :edit, :update, :destroy]

  # GET /wahuiboards or /wahuiboards.json
  def index
    @wahuiboards = Wahuiboard.all
  end

  # GET /wahuiboards/1 or /wahuiboards/1.json
  def show
  end

  # GET /wahuiboards/new
  def new
    @wahuiboard = Wahuiboard.new
  end

  # GET /wahuiboards/1/edit
  def edit
  end

  def create
    @wahuiboard = Wahuiboard.new(wahuiboard_params)

    respond_to do |format|
      if @wahuiboard.save
        # Handle image upload (assuming 'image' is the attachment field)
        if params[:wahuiboard][:image].present?
          @wahuiboard.image.attach(params[:wahuiboard][:image])
        end

        format.html { redirect_to @wahuiboard, notice: "Wahuiboard was successfully created." }
        format.json { render :show, status: :created, location: @wahuiboard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wahuiboard.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def wahuiboard_params
    params.require(:wahuiboard).permit(:name, :description, :image)
  end

  # PATCH/PUT /wahuiboards/1 or /wahuiboards/1.json
  def update
    respond_to do |format|
      if @wahuiboard.update(wahuiboard_params)
        format.html { redirect_to @wahuiboard, notice: "Wahuiboard was successfully updated." }
        format.json { render :show, status: :ok, location: @wahuiboard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wahuiboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wahuiboards/1 or /wahuiboards/1.json
  def destroy
    @wahuiboard.destroy!

    respond_to do |format|
      format.html { redirect_to wahuiboards_path, status: :see_other, notice: "Wahuiboard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_wahuiboard
    @wahuiboard = Wahuiboard.find(params[:id])
  end
end