require 'csv'
require 'sunlight/congress'

def clean_zip(zipcode)
  zipcode.rjust(5, '0')[0..4]
end

def legislator_by_zipcode(zip_code)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zip_code)
  legislator_names = legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end
  legislator_string = legislator_names.join(', ')
  return  legislator_string
end

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

puts "Legislators initialize"


contents =  CSV.open "event_attendes.csv", headers: true, header_converters: :symbol

contents.each do |line|
  name = line[:first_name]
  zip_code = clean_zip(line[:zipcode].to_s)
  legislator = legislator_by_zipcode(zip_code)

  puts "#{name} #{zip_code} #{legislator}"
end