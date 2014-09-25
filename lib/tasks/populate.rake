namespace :db do
  desc "Create Balance"
  task :populate => :environment do
    require 'populator'
    Balance.populate 100 do |balance|
      balance.price =  (Random.new).rand(100)
      balance.state=['buy', 'sell']
    end
    puts 'All done'
  end
end
