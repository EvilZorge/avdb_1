class NaturalPeopleController < ApplicationController
  def index
    @q = NaturalPerson.search(params[:q])
    @people = @q.result.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @natural_person = NaturalPerson.new
  end

  def create
    @natural_person = NaturalPerson.new(natural_person_params)
    if @natural_person.save
      flash[:success] = 'Физическое лицо создано'
      redirect_to action: 'index'
    else
      flash[:error] = 'Проверьте ваши данные'
      render 'new'
    end
  end

  def edit
    @natural_person = NaturalPerson.find(params[:id])
  end

  def update
    @natural_person = NaturalPerson.find(params[:id])
    if @natural_person.update_attributes(natural_person_params)
      flash[:success] = 'Физическое лицо обновлено'
      redirect_to action: 'index'
    else
      flash[:error] = 'Проверьте ваши данные'
      render 'edit'
    end
  end

  def destroy
    @natural_person = NaturalPerson.find(params[:id])
    @natural_person.destroy
    flash[:success] = 'Физическое лицо удалено'
    redirect_to action: 'index'
  end


  def send_email
    @person = NaturalPerson.find(params[:id])
    PersonMailer.welcome_email(@person).deliver
    flash[:success] = "Письмо было отправлено пользователю #{@person.surname} #{@person.name} #{@person.middlename} "
    redirect_to :back
  end

  def multiple_email_send
    if params[:natural_person_ids]
      @people = NaturalPerson.find(params[:natural_person_ids])
      @people.each do |person|
        PersonMailer.welcome_email(person).deliver
      end
      flash[:success] = "Письма отправлены"
      redirect_to :back
    else
      flash[:error] = 'Проверьте ваши данные'
      redirect_to :back
    end
  end

  def send_sms
    @person = NaturalPerson.find(params[:id])
    @client = Twilio::REST::Client.new ENV['TWILIO_ID'], ENV['TWILIO_SECRET']
    @client.account.messages.create( from: ENV['TWILIO_PHONE'], to: @person.phone, body: "Hey, #{@person.name}")
  end

  private

  def natural_person_params
    params.require(:natural_person).permit(:name, :surname, :middlename, :address, :passport_data, :phone, :email, :skype,
    :work_place, :function, :marital_status)
  end

end
