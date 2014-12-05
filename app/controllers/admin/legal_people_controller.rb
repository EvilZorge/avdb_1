class Admin::LegalPeopleController < ApplicationController
  load_and_authorize_resource

  def index
    @q = LegalPerson.search(params[:q])
    @people = @q.result.paginate(:page => params[:page], :per_page => 30)
  end


  def edit
  end

  def update
    if @legal_person.update_attributes(legal_person_params)
      flash[:success] = 'Legal person was updated'
      redirect_to action: 'index'
    else
      flash[:error] = 'Check your data'
      render 'edit'
    end
  end

  def destroy
    @legal_person.destroy
    flash[:success] = 'Legal person was deleted'
    redirect_to action: 'index'
  end

  def send_email
    @person = LegalPerson.find(params[:id])
    PersonMailer.welcome_email(@person).deliver
    flash[:success] = "Email was send to #{@person.name}"
    redirect_to :back
  end

  def multiple_email_send
    if params[:legal_person_ids]
      @people = LegalPerson.find(params[:legal_person_ids])
      @people.each do |person|
        PersonMailer.welcome_email(person).deliver
      end
      flash[:success] = "Emails were send"
      redirect_to :back
    else
      flash[:error] = 'Check your data'
      redirect_to :back
    end
  end

  def send_sms
    @person = LegalPerson.find(params[:id])
    @client = Twilio::REST::Client.new ENV['TWILIO_ID'], ENV['TWILIO_SECRET']
    @client.account.messages.create( from: ENV['TWILIO_PHONE'], to: @person.phone, body: "Hey, #{@person.name}")
  end

  private

  def legal_person_params
    params.require(:legal_person).permit(:name, :address, :registration_code, :leader, :accountant_general, :director, :sub_company, :phone,
                                         :email, :skype, :creation_date)
  end
end
