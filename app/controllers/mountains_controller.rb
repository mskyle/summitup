class MountainsController < ApplicationController
  def new
    @mountain = Mountain.new
  end

  def create
    @mountain = Mountain.new(mountain_params)

    respond_to do |format|
      if @mountain.save
        format.html { redirect_to @mountain, notice: "awesome! you've added a mountain." }
        format.json { render action: 'show', status: :created, location: @mountain }
      else
        format.html { render action: 'new' }
        format.json { render json: @mountain.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def index
    if params[:q]
      query = "%#{params[:q].downcase}%"
      @mountains = Mountain.where("lower(name) LIKE ? ", query).limit(10)
    else
      @mountains = Mountain.all
    end
    respond_to do |format|
      format.json { render json: @mountains }
      format.html
    end
  end

  private

  def mountain_params
    params.require(:mountain).permit(:name, :height, :latitude, :longitude)
  end

end