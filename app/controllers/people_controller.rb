class PeopleController < ApplicationController
  def index
  end

  def send_sms
    @person = NaturalPerson.find(params[:id])
    @client = Twilio::REST::Client.new ENV['TWILIO_ID'], ENV['TWILIO_SECRET']
    @client.account.messages.create( from: ENV['TWILIO_PHONE'], to: '+375291201402', body: "Hey, #{@person.name}")
  end
end
