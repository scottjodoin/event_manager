require "csv"
require "google/apis/civicinfo_v2"
require 'erb'

class EventManager
  CivicInfo = Google::Apis::CivicinfoV2
  @civic_info = CivicInfo::CivicInfoService.new
  @civic_info.key = File.read("../keys/civic_api.key").strip

  def legislators_by_zipcode(zipcode)
    begin
      legislators = @civic_info.representative_info_by_address(
        address: zipcode,
        levels: 'country',
        roles: ['legislatorUpperBody', 'legislatorLowerBody']
      ).officials
    rescue
      "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
    end
  end

  def self.clean_zip_code (zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  puts "EventManager Initialized!"

  def do_stuff
    contents = CSV.open "./event_attendees.csv", headers: true, header_converters: :symbol
    template_letter = File.read "./form_letter.html"
    erb_template = ERB.new template_letter

    contents.each do |row|
      name = row[:first_name]

      zipcode = row[:zipcode]

      legislators = legislators_by_zipcode(zipcode)

      puts form_letter = erb_template.result(binding)
    end
  end
end

em =  EventManager.new
em.do_stuff
