class Admin::NaturalPeopleController < ApplicationController
  load_and_authorize_resource

  def index
    @q = NaturalPerson.search(params[:q])
    @people = @q.result.paginate(:page => params[:page], :per_page => 30)
  end

  def edit
  end

  def update
    if @natural_person.update_attributes(natural_person_params)
      flash[:success] = 'Natural person was updated'
      redirect_to action: 'index'
    else
      flash[:error] = 'Проверьте ваши данные'
      render 'edit'
    end
  end

  def destroy
    @natural_person.destroy
    flash[:success] = 'Natural person was deleted'
    redirect_to action: 'index'
  end


  def send_email
    @person = NaturalPerson.find(params[:id])
    PersonMailer.welcome_email(@person).deliver
    flash[:success] = "Email was send #{@person.surname} #{@person.name} #{@person.middlename} "
    redirect_to :back
  end

  def multiple_email_send
    if params[:natural_person_ids]
      @people = NaturalPerson.find(params[:natural_person_ids])
      @people.each do |person|
        PersonMailer.welcome_email(person).deliver
      end
      flash[:success] = "Emails were send"
      redirect_to :back
    else
      flash[:error] = 'Check yor data'
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
