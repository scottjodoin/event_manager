class EventManager
  require "csv"
  puts "EventManager Initialized!"

  contents = CSV.open "./event_attendees.csv", headers: true, header_converters: :symbol
  contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]
  puts "#{name} #{zipcode}"
  end

  def self.clean_zip_code (zipcode)
    puts test
    zipcode.to_s.rjust(5,"0")[0..4]
  end
end
