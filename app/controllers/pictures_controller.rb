class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy]
  before_action :logged_in?
  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures or /pictures.json
  def create
    @picture = current_user.pictures.build(picture_params)
    # @user = @picture.user.name
    # @picture.user_id = current_user.id
      if params[:back]
        render :new
      else
        respond_to do |format|
        if @picture.save
          format.html { redirect_to @picture, notice: "Picture was successfully created." }
          format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    respond_to do |format|
      if params[:id] =! "confirm"
      elsif @picture.update(picture_params)
        format.html { redirect_to @picture, notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    # @user = @picture.user.name
    # @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:index,:post,:image,:image_cache,:user_id)
  end

  # def user_params
  #   params.require(:user).permit(:name,:user_id)
  # end

end
