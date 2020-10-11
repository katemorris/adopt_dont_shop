class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new

  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.new(shelter_params)
    shelter.save

    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    @shelter.save
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  def pets
    @shelter = Shelter.find(params[:id])
    if params[:adoptable] == "true"
      @pets_list = @shelter.pets.adoptable_filter
    elsif params[:adoptable] == "false"
      @pets_list = @shelter.pets.pending_filter
    else
      @pets_list = @shelter.pets.adoptable_first
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
