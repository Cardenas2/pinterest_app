class PinsController < ApplicationController
	before_action :set_pin, only:[:like, :destroy,:update,:edit, :show
	]
  def index
  	@pins = Pin.all
  end

  def show
  end

  def edit

  end

  def like
  	Like.create(pin: pin, user: current_user)
  	redirect_to_pins_path
  end


  def new
  	 @pin = Pin.new
  end

  def create
  	@pin = Pin.new(pins_params)
  	@pin.user =  current_user
  	if @pin.save!
  		redirect_to pins_path
  	else
  		redirect new_pin_path, notice: 'Error desconocido'
  	end
  end
  def destroy
     @pin.likes.delete_all
     @pin.delete
     redirect_to pins_path
  end

  def update
  	@pin.update(pins_params)
  	redirect_to pins_path
  end

  private

  def pins_params
  	params.require(:pin).permit(:name, :desc, :photo)
  	
  end
  def set_pin
  	@pin =Pin.find(params[:id])
  end


end
