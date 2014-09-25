class BankController < ApplicationController
require 'open-uri'

  def index
  end

  def select
    url = "http://www.nbrb.by/Services/XmlExRates.aspx?ondate="+params[:data]
    doc = Nokogiri::XML(open(url))
    @data = doc.xpath("//Currency").map{ |t| [t.elements[1].children.text, t.elements[3].children.text, t.elements[4].children.text] }
    binding.pry
  end
end
