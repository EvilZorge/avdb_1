# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
credit_name = ["on consumption up to 1 year","on consumption up to 5 years", "Time-tested", "credit 'Application Santa Claus'"];
credit_amount = "within the solvency of the borrower"
credit_condition = "on a universal basis"
credit_time = ["up to 1 year","up to 5 years","until the borrower 57 years of age", "up to 1 year"] 
credit_rate = ["34.5","36.5","35.5","31.12"]
credit_form = ["bank transfer to the account of third parties","bank transfer to the account of third parties","bank transfer to the account of third parties","the banking credit payment card without renewal of the credit line"]
credit_term = ["simultaneous provision of funds","open credit line", "simultaneous provision of funds", "open credit line"]
credit_currency = "belarusian rubles"

CreditKind.create(name: credit_name[0],max_amount:credit_amount,condition:credit_condition,max_time:credit_time[0],rate:credit_rate[0],form_kind:credit_form[0],term:credit_term[0],currency:credit_currency ) 
CreditKind.create(name: credit_name[1],max_amount:credit_amount,condition:credit_condition,max_time:credit_time[1],rate:credit_rate[1],form_kind:credit_form[1],term:credit_term[1],currency:credit_currency ) 
CreditKind.create(name: credit_name[2],max_amount:credit_amount,condition:credit_condition,max_time:credit_time[2],rate:credit_rate[2],form_kind:credit_form[2],term:credit_term[2],currency:credit_currency )
CreditKind.create(name: credit_name[3],max_amount:credit_amount,condition:credit_condition,max_time:credit_time[3],rate:credit_rate[3],form_kind:credit_form[3],term:credit_term[3],currency:credit_currency ) 
