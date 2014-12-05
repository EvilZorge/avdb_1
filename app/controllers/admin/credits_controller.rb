class Admin::CreditsController < ApplicationController
  load_and_authorize_resource

  def index
    @credits = Credit.all
  end

  def show
  end

  def change_state
    if @credit.fire_state_event(params[:state])
      if @credit.state == "approved"
          if !(@credit.user.legal_person.nil?)
            PersonMailer.welcome_email(@credit.user.legal_person).deliver
            flash[:success] = "Email was send to #{@credit.user.legal_person.name}"
          else 
            PersonMailer.welcome_email(@credit.user.natural_person).deliver
            flash[:success] = "Email was send to #{@credit.user.natural_person.name}"
          end   
      end      
      flash[:notice] = "Credit's state was changed to #{@credit.state}!"
      redirect_to :back
    else
      flash[:alert] = 'Something wrong'
      render 'index'
    end
  end

  def create_contract
    @credit = Credit.find(params[:id])
    if @credit.time.include? 'month'
      money = (@credit.amount.to_i * (1 + @credit.credit_kind.rate.to_f/100))/@credit.time.to_i
    elsif @credit.time.include? 'year'
      money = (@credit.amount.to_i * (1 + @credit.credit_kind.rate.to_f/100))/(@credit.time.to_i * 12)
    end
    if Contract.create(credit_id: @credit.id, money: money)
      flash[:notice] = "Contract was created"
    else
      flash[:notice] = "Something wrong"
    end
    redirect_to :back
  end

  def contract_field
    @credit = Credit.find(params[:search])
    @contract = @credit.contract
    render json: {data: @contract}
  end

  private

  def credit_params
    params.require(:credit).permit(:state)
  end
end