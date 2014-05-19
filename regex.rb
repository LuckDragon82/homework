require 'json'

def process_file
  File.open('test_regex', 'r') do |file|
    file.each_line do |msg|
      acme_text_msg_to_json msg
    end
  end
end

def acme_text_msg_to_json(text_msg)
  matcher = /(?<feature>[a-zA-Z]+\s?[a-zA-Z]+\s[^\-]?\s\d+)\s(?<date_range>[0-9\/]+\s[^\-]\s[0-9\/]+)\s(?<price>[0-9\.]+)/.match(text_msg)
  json =  {
      'feature' => matcher['feature'],
      'date_range' => matcher['date_range'],
      'price' => matcher['price']
  }.to_json
  puts json
end
process_file


#txt = '$4.99 TXT MESSAGING – 250 09/29 – 10/28 14.99'
#
#puts acme_text_msg_to_json(txt)