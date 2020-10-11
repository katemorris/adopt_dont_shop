class PetsController < ApplicationController
  def index
    @pets = Pet.all
    if params[:adoptable] == "true"
      @pets_list = @pets.adoptable_filter
    elsif params[:adoptable] == "false"
      @pets_list = @pets.pending_filter
    else
      @pets_list = @pets.adoptable_first
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    pet = Pet.create(pet_params)
    redirect_to "/shelters/#{pet.shelter_id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    @pet.save
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])

    flash[:notice] = 'Pet removed'
    redirect_to '/pets'
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :sex, :approximate_age, :shelter_id, :status)
  end
end
