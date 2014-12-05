class CreditsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @credit.user = current_user
    if @credit.save
      flash[:notice] = 'Credit was created'
      redirect_to @credit.user
    else
      flash[:alert] = 'Check your data'
      render 'new'
    end
  end

  def set_kind
    if params[:search]
      @credit_kind = CreditKind.find(params[:search])
      render json: {data: @credit_kind}
    end
  end


  private

  def credit_params
    params.require(:credit).permit(:credit_kind_id, :amount, :time, :purpose)
  end
end