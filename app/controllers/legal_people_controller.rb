class LegalPeopleController < ApplicationController
  def index
    @q = LegalPerson.search(params[:q])
    @people = @q.result.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @legal_person = LegalPerson.new
  end

  def create
    @legal_person = LegalPerson.new(legal_person_params)
    if @legal_person.save
      flash[:success] = 'Юридическое лицо создано'
      redirect_to action: 'index'
    else
      flash[:error] = 'Проверьте ваши данные'
      render 'new'
    end
  end

  def edit
    @legal_person = LegalPerson.find(params[:id])
  end

  def update
    @legal_person = LegalPerson.find(params[:id])
    if @legal_person.update_attributes(legal_person_params)
      flash[:success] = 'Юридическое лицо обновлено'
      redirect_to action: 'index'
    else
      flash[:error] = 'Проверьте ваши данные'
      render 'edit'
    end
  end

  def destroy
    @legal_person = LegalPerson.find(params[:id])
    @legal_person.destroy
    flash[:success] = 'Юридическое лицо удалено'
    redirect_to action: 'index'
  end

  def send_email
    @person = LegalPerson.find(params[:id])
    PersonMailer.welcome_email(@person).deliver
    flash[:success] = "Письмо было отправлено пользователю #{@person.name}"
    redirect_to :back
  end

  def multiple_email_send
    if params[:legal_person_ids]
      @people = LegalPerson.find(params[:legal_person_ids])
      @people.each do |person|
        binding.pry
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
    @person = LegalPerson.find(params[:id])
    @client = Twilio::REST::Client.new ENV['TWILIO_ID'], ENV['TWILIO_SECRET']
    binding.pry
    @client.account.messages.create( from: ENV['TWILIO_PHONE'], to: @person.phone, body: "Hey, #{@person.name}")
  end

  private

  def legal_person_params
    params.require(:legal_person).permit(:name, :address, :registration_code, :leader, :accountant_general, :director, :sub_company, :phone,
                                         :email, :skype, :creation_date)
  end
end
