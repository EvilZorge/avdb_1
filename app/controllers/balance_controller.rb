class BalanceController < ApplicationController

  def index
    @balance = Balance.all
    @group=  @balance.sort_by(&:price).group_by{ |t| t.price/10}
    @number=Array.new
    @group.each do |key, value|
      @number[key]= Hash[value.group_by(&:state).map {|k,v|  [k,v.sum(&:price) ]}]
    end
    #binding.pry 
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({:defaultSeriesType=>"column"})
      f.plot_options({:column=>{:stacking=>"normal"}})
      f.title(:text => "Balance of sold and bought in increments of 10 ")
      f.xAxis(:categories => [10,20,30,40,50,60,70,80,90,100])
      f.series(:name => "Sell", :data => @number.map  {|x| x['sell'] }, color: '#92B1D4')
      f.series(:name => "Buy", :data => @number.map  {|x| x['buy'] * (-1) }, color: '#AF6A86')
      f.yAxis [
        {:title => {:text => "Sell", :margin => 70} },
      {:title => {:text => "Buy"}, :opposite => true} ]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    end
    @chartSecond = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({:defaultSeriesType=>"column"})
      f.plot_options({:column=>{:stacking=>"normal"}})
      f.title(:text => "Full balance's amount of sold and bought assets")
      f.xAxis(:categories => ['All'])
      f.series(:name => "Sell", :yAxis => 0, :data => [@balance.where(state:'sell').sum(:price)], color: '#92B1D4' )
      f.series(:name => "Buy", :yAxis => 0, :data => [@balance.where(state:'buy').sum(:price) * (-1)], color: '#AF6A86')
      f.yAxis [
        {:title => {:text => "Sell", :margin => 70} },
      {:title => {:text => "Buy"}, :opposite => true},]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    end
  end


end