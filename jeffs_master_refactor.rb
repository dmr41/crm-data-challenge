require 'pp'
require_relative '../data/crm.rb'

def employments_for(person, company)
  person[:employments].select do |employment|
    employment[:company_id] == company[:id]
  end
end

def employees_of(company)
  CRM[:people].flat_map do |person|
    employments_for(person, company).map do |employment|
      {
        id: person[:id],
        first_name: person[:first_name],
        last_name: person[:last_name],
        title: employment[:title]
      }
    end
  end
end

final_array = CRM[:companies].map do |company|
  { name: company[:name], employees: employees_of(company) }
end

pp final_array
