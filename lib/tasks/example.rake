namespace :db do
  desc "Create example for lab 3"
  task :example => :environment do
    require 'populator'
    NaturalPerson.populate 100000 do |person|
      gender = Ryba::Name.gender
      person.name =  Ryba::Name.first_name(gender)
      person.surname = Ryba::Name.family_name(gender)
      person.middlename = Ryba::Name.middle_name(gender)
      person.address = Ryba::Address.postal
      person.passport_data = ['AB','BM', 'HB', 'KH', 'MP', 'MC', 'KB'].sample + Faker::Number.number(7)
      person.phone = Faker::Base.numerify('+375(29) ### ####')
      person.email = Faker::Internet.email
      person.skype = Faker::Internet.user_name
      person.age = [18..80].sample
      person.income = rand(7)
      person.work_place = Ryba::Company.name(:solidity => 3)
      person.function = ['директор', 'уборщик(ца)', 'бухгалтер', 'программист', 'инженер', 'главный инженер', 'системный администратор',
                         'тестировщик', 'продавец', 'менеджер', 'сантехник', 'электрик', 'повар']
      if gender
        person.marital_status = ['женат', 'холост']
      else
        person.marital_status = ['замужем', 'не замужем' ]
      end
    end
    LegalPerson.populate 100000 do |person|
      person.name =  Ryba::Company.name(:solidity => 3)
      person.address = Ryba::Address.postal
      person.registration_code = Faker::Number.number(6)
      person.leader = Ryba::Name.full_name
      person.accountant_general = Ryba::Name.full_name
      person.director = Ryba::Name.full_name
      person.sub_company = Ryba::Company.name(:solidity => 2)
      person.phone = Faker::Base.numerify('+375(29) ### ####')
      person.email = Faker::Internet.email
      person.skype = Faker::Internet.user_name
      person.income = rand(10)
      person.creation_date = Faker::Date.backward(rand(5000))
    end
    puts 'All done'
  end
end

