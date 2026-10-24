class Admin::ColorsController < ApplicationController
  load_and_authorize_resource
  before_action :set_color, only: %i[ show edit update destroy ]

  # GET /colors or /colors.json
  def index
    @colors = Color.all
  end

  # GET /colors/1 or /colors/1.json
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
  end

  # GET /colors/1/edit
  def edit
  end

  # POST /colors or /colors.json
  def create
    @color = Color.new(color_params)
    # @color.rgb_hash.slice!(0) if @color.rgb_hash[0] == "#"
    @color.user = current_user

    respond_to do |format|
      if @color.save
        format.html { redirect_to [:admin, @color], notice: "Color was successfully created." }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @color.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /colors/1 or /colors/1.json
  def update
    # @color.rgb_hash.slice!(0) if @color.rgb_hash[0] == "#"

    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to [:admin, @color], notice: "Color was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @color.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /colors/1 or /colors/1.json
  def destroy
    @color.destroy!

    respond_to do |format|
      format.html { redirect_to admin_colors_path, notice: "Color was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def color_params
      color_params = params.expect(color: [ :rgb_hash ])

      if color_params[:rgb_hash].start_with?('#')
        color_params[:rgb_hash] = color_params[:rgb_hash].delete_prefix('#')
      end

      color_params
    end
end
