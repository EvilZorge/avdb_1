class NaturalPeopleController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @natural_person.user = current_user
    if @natural_person.save
      flash[:notice] = 'Физическое лицо создано'
      redirect_to @natural_person.user
    else
      flash[:alert] = 'Проверьте ваши данные'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @natural_person.update_attributes(natural_person_params)
      flash[:notice] = 'Физическое лицо обновлено'
      redirect_to @natural_person.user
    else
      flash[:alert] = 'Проверьте ваши данные'
      render 'edit'
    end
  end

  private

  def natural_person_params
    params.require(:natural_person).permit(:name, :surname, :middlename, :address, :passport_data, :phone, :email, :skype,
    :work_place, :function, :marital_status, :user_id)
  end

end
