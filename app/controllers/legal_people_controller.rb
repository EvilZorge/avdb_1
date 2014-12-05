class LegalPeopleController < ApplicationController
  load_and_authorize_resource

  def new

  end

  def create
    @legal_person.user = current_user
    if @legal_person.save
      flash[:notice] = 'Legal person was created'
      redirect_to @legal_person.user
    else
      flash[:alert] = 'Check your data'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @legal_person.update_attributes(legal_person_params)
      flash[:notice] = 'Legal person was updated'
      redirect_to @legal_person.user
    else
      flash[:alert] = 'Check your data'
      render 'edit'
    end
  end

  private

  def legal_person_params
    params.require(:legal_person).permit(:name, :address, :registration_code, :leader, :accountant_general, :director, :sub_company, :phone,
                                         :email, :skype, :creation_date, :user_id)
  end
end
