require 'pp'
require_relative '../data/crm.rb'

def ch_one
  final_array = []
  CRM[:companies].each do |company|
    final_hash ={}
    new_array = []
    final_hash[:name] = company[:name]
    CRM[:people].each do |person|
      person[:employments].each do |employ|
        if employ[:company_id] == company[:id]
          new_array << {id: person[:id],
          first_name: person[:first_name],
          last_name: person[:last_name],
          title: employ[:title]}
          final_hash[:employees] = new_array
        end
     end
    end
    final_array << final_hash
  end
  pp final_array
end

def ch_two
  final_array = []
  CRM[:companies].each do |company|
    hash = {company_id: company[:id], company_name: company[:name],
            person_id: nil, person_first_name: nil,
            person_last_name: nil, title: nil}
    CRM[:people].each do |person|
      person[:employments].each do |employ|
        if employ[:company_id] == company[:id]
          hash = {company_id: company[:id], company_name: company[:name],
                  person_id: person[:id], person_first_name: person[:first_name],
                  person_last_name: person[:last_name],
                  title: employ[:title]}
        end
      end
      if hash[:person_id]
        final_array << hash
      end
    end
  end
  pp final_array
end

final_array = []
  CRM[:people].each do |person|
    hash = {person_id: nil, first_name: nil,
            last_name: nil}
    if person[:employments].empty?
        hash = {person_id: person[:id],
                first_name: person[:first_name],
                last_name: person[:last_name]}
    end
    unless hash[:person_id].nil?
     final_array << hash
    end
  end
 pp final_array
