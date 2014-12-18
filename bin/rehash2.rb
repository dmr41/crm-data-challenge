require 'pp'
# require_relative '../data/crm.rb'

def ch_one(hashes)
  # CRM = hashes
  final_array = []
  hashes[:companies].each do |company|
    final_hash ={}
    new_array = []
    final_hash[:name] = company[:name]
    hashes[:people].each do |person|
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

def ch_two(hashes)
  # CRM = hashes
  final_array = []
  hashes[:companies].each do |company|
    hash = {company_id: company[:id], company_name: company[:name],
            person_id: nil, person_first_name: nil,
            person_last_name: nil, title: nil}
    hashes[:people].each do |person|
      person[:employments].each do |employ|
        if employ[:company_id] == company[:id]
          hash = {company_id: company[:id], company_name: company[:name],
                  person_id: person[:id], person_first_name: person[:first_name],
                  person_last_name: person[:last_name],
                  title: employ[:title]}
        end
      end
    end
      if hash[:person_id]
        final_array << hash
      end
  end
  pp final_array
end

def ch_three(hashes)
  # CRM = hashes
  final_array = []
  hashes[:people].each do |person|
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
end

require 'rspec/autorun'

RSpec.describe '#ch_one' do
  it 'employees of companies' do
    input = {
      :people => [
        {
          :id => 45,
          :first_name => "Empty",
          :last_name => "Empterson",
          :employments => []
        },
        {
          :id => 333,
          :first_name => "Wayne",
          :last_name => "Weineuss",
          :employments =>
          [
            {
              :company_id => 98,
              :title => "God"
            },
            {
              :company_id => 7,
              :title => "Monkey grunt"
            }

          ]
          },{
            :id => 987766,
            :first_name => "Single",
            :last_name => "Singleson",
            :employments =>
            [
              {
                :company_id => 667,
                :title => "Lord"
              }
            ]
          }
        ],
        :companies => [
          {
            :id => 98,
            :name => "gSchool Inc"
          },
          {
            :id => 7,
            :name => "Lucky Lucks"
          },
          {
            :id => 667,
            :name => "The Killing Field of Greens"
          }

        ]
      }

    expected_result = [
      {
        name: "gSchool Inc",
        employees: [
          {
            :id => 333,
            :first_name => "Wayne",
            :last_name => "Weineuss",
            :title => "God"
          }
        ]
      },
      {
        name: "Lucky Lucks",
        employees: [
          {
            :id => 333,
            :first_name => "Wayne",
            :last_name => "Weineuss",
            :title => "Monkey grunt"
          }
        ]
      },
      {
        name: "The Killing Field of Greens",
        employees: [
          {
            :id => 987766,
            :first_name => "Single",
            :last_name => "Singleson",
            :title => "Lord"
          }
        ]
      }
    ]

    expect(ch_one(input)).to eq(expected_result)
  end
end

RSpec.describe '#ch_two' do
  it 'all employments' do
    input = {
              :people => [
              {
                :id => 45,
                :first_name => "Empty",
                :last_name => "Empterson",
                :employments => []
              },
              {
                :id => 333,
                :first_name => "Wayne",
                :last_name => "Weineuss",
                :employments =>
                [
                  {
                    :company_id => 98,
                    :title => "God"
                  },
                  {
                    :company_id => 7,
                    :title => "Monkey grunt"
                  }

                ]
                },{
                  :id => 987766,
                  :first_name => "Single",
                  :last_name => "Singleson",
                  :employments =>
                  [
                    {
                      :company_id => 667,
                      :title => "Lord"
                    }
                  ]
                }
              ],
              :companies => [
                {
                  :id => 98,
                  :name => "gSchool Inc"
                },
                {
                  :id => 7,
                  :name => "Lucky Lucks"
                },
                {
                  :id => 667,
                  :name => "The Killing Field of Greens"
                }

              ]
            }

    expected_result = [
      {
        :company_id => 98,
        :company_name => "gSchool Inc",
        :person_id => 333,
        :person_first_name => "Wayne",
        :person_last_name => "Weineuss",
        :title => "God"
      },
      {
        :company_id => 7,
        :company_name => "Lucky Lucks",
        :person_id => 333,
        :person_first_name => "Wayne",
        :person_last_name => "Weineuss",
        :title => "Monkey grunt"
      },
      {
        :company_id => 667,
        :company_name => "The Killing Field of Greens",
        :person_id => 987766,
        :person_first_name => "Single",
        :person_last_name => "Singleson",
        :title => "Lord"
      }
    ]

    expect(ch_two(input)).to eq(expected_result)
  end
end

RSpec.describe '#ch_three' do
  it 'returns a hash where the values are arrays of items, grouped by the :id key' do
    input = {
      :people => [
        {
          :id => 45,
          :first_name => "Empty",
          :last_name => "Empterson",
          :employments => []
        },
        {
          :id => 333,
          :first_name => "Wayne",
          :last_name => "Weineuss",
          :employments =>
          [
            {
              :company_id => 98,
              :title => "God"
            },
            {
              :company_id => 7,
              :title => "Monkey grunt"
            }

          ]
          },{
            :id => 987766,
            :first_name => "Single",
            :last_name => "Singleson",
            :employments =>
            [
              {
                :company_id => 667,
                :title => "Lord"
              }
            ]
          }
        ],
        :companies => [
          {
            :id => 98,
            :name => "gSchool Inc"
          },
          {
            :id => 7,
            :name => "Lucky Lucks"
          },
          {
            :id => 667,
            :name => "The Killing Field of Greens"
          }

        ]
      }

    expected_result = [
      {
        :person_id => 45,
        :first_name => "Empty",
        :last_name => "Empterson"
      }
    ]
    expect(ch_three(input)).to eq(expected_result)
  end
end
