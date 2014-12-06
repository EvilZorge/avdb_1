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


  def contract_field
    @credit = Credit.find(params[:search])
    @contract = @credit.contract
    if !(@credit.user.legal_person.nil?)
      render json: {data: [@contract, @credit,@credit.user.legal_person]  }
    else  
      render json: {data: [@contract, @credit,@credit.user.natural_person]  }
    end 
  end

  def payment
    @credit = Credit.find(params[:search])
    @contract = @credit.contract
    if @credit.time.include? 'month'
      @month = months_between((@contract.created_at.to_time).strftime('%m/%d/%Y'), (@contract.created_at.to_time + @credit.time.to_i.months).strftime('%m/%d/%Y'))
    elsif @credit.time.include? 'year'
       @month = months_between((@contract.created_at.to_time).strftime('%m/%d/%Y'), (@contract.created_at.to_time + @credit.time.to_i.years).strftime('%m/%d/%Y') )
    end
      render json: {data: [@contract, @credit, @month, @credit.credit_kind]  }
  end


  private

  def credit_params
    params.require(:credit).permit(:credit_kind_id, :amount, :time, :purpose, credit_files_attributes: [:id, :document, :_destroy])
  end

  def months_between(d1, d2)
    d1, d2 = [d1, d2].map{ |d| Date.parse(d) }.minmax
    months = (d2.mon - d1.mon) + (d2.year - d1.year) * 12
    (d1.mon ... (d1.mon + months)).each_with_object(Date::ABBR_MONTHNAMES[d1.mon, 1]) { |month_offset, month_names_array|
      month_names_array << Date::ABBR_MONTHNAMES[(d1 >> month_offset).mon]
    }
  end
end