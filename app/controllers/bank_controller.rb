class BankController < ApplicationController
require 'open-uri'

  def index
  end

  def select 
    if Currency.any?
      Currency.delete_all
    end
    url = "http://www.nbrb.by/Services/XmlExRates.aspx?ondate="+params[:data]
    urlToday = "http://www.nbrb.by/Services/XmlExRates.aspx?ondate"+Date.today.strftime("%m/%d/%y")
    doc = Nokogiri::XML(open(url))
    docToday = Nokogiri::XML(open(urlToday))
    #binding.pry
    @dataToday= docToday.xpath("//Currency").map{ |t| t.elements[4].children.text }
    @data = doc.xpath("//Currency").map{ |t| [t.elements[1].children.text, t.elements[3].children.text, t.elements[4].children.text, t.first[1]] }
    @data.count.times do |i|
      Currency.create(id: i, charcode: @data[i][0], name: @data[i][1], rate: @data[i][2], rateToday: @dataToday[i], currency_id: @data[i][3])
    end
    @currency=Currency.all
  end

  def reload
    @tableCurrency = Currency.find params[:info]
    render json: {data: @tableCurrency}
  end

  def convert
    @first = Currency.find_by(charcode: params[:firstCountry])
    @second = Currency.find_by(charcode: params[:secondCountry])
    @amount = params[:amount]
    if params[:firstCountry]=="BLR"
      @first = Hash['rateToday' => 1]
    end
    if params[:secondCountry] == "BLR"
      @second = Hash['rateToday' => 1] 
    end
    @result = (@amount.to_f * @first['rateToday'].to_f/@second['rateToday'].to_f).round(3)
    render json: {data: @result}
  end

  def build
    @data = Currency.find params[:graph]    
    url = "http://www.nbrb.by/Services/XmlExRatesDyn.aspx?curId="+@data.currency_id.to_s+
      "&fromDate="+(Date.today-15).strftime("%m/%d/%y")+"&toDate="+Date.today.strftime("%m/%d/%y")
    urlMonth = "http://www.nbrb.by/Services/XmlExRatesDyn.aspx?curId="+@data.currency_id.to_s+
      "&fromDate="+(Date.today-1.month).strftime("%m/%d/%y")+"&toDate="+Date.today.strftime("%m/%d/%y")  
    doc = Nokogiri::XML(open(url))
    docMonth = Nokogiri::XML(open(urlMonth))
    @result = Hash[ 'date' => doc.xpath("//Currency").map{ |t| [t.elements.map { |i| i.attributes['Date'].value}]}, 
      'value' => doc.xpath("//Currency").map{ |t| [ t.elements.map {|i| i.children.text.to_i}]}]

    @resultMonth = Hash[ 'date' => docMonth.xpath("//Currency").map{ |t| [t.elements.map { |i| i.attributes['Date'].value}]}, 
      'value' => docMonth.xpath("//Currency").map{ |t| [ t.elements.map {|i| i.children.text.to_i}]}]  
    #binding.pry  
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({
            type: 'line'})
      f.title(:text => "Последние 15 дней")
      f.xAxis(:categories => @result['date'][0][0])
      f.series(:name => "Значение", :yAxis => 0, :data => @result['value'][0][0], color: 'red')
      f.yAxis [
        {:title => {:text => "Значение валюты", :margin => 70} }]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    end
    @chartSecond = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({
            type: 'line'})
      f.title(:text => "Последний месяц")
      f.xAxis(:categories => @resultMonth['date'][0][0])
      f.series(:name => "Значение", :yAxis => 0, :data => @resultMonth['value'][0][0], color: 'green')
      f.yAxis [
        {:title => {:text => "Значение валюты", :margin => 70} }]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    end
  end
end

