class LegalPeopleController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @legal_person.save
      flash[:notice] = 'Юридическое лицо создано'
      redirect_to :back
    else
      flash[:alert] = 'Проверьте ваши данные'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @legal_person.update_attributes(legal_person_params)
      flash[:notice] = 'Юридическое лицо обновлено'
      redirect_to :back
    else
      flash[:alert] = 'Проверьте ваши данные'
      render 'edit'
    end
  end

  private

  def legal_person_params
    params.require(:legal_person).permit(:name, :address, :registration_code, :leader, :accountant_general, :director, :sub_company, :phone,
                                         :email, :skype, :creation_date)
  end
end
