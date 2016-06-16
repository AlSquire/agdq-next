require 'nokogiri'
require 'open-uri'

def fetch
  url = "https://gamesdonequick.com/schedule"
  doc = Nokogiri::HTML(open(url))
  times = doc.css('#runTable tr').map do |tr|
    time = tr.elements[0].text
    text = tr.elements[1].text
    [time_parse(time), text]
  end

  now = times.select { |t| t[0] < Time.now }.last
  incomings = times.select { |t| t[0] > Time.now }[0..5]
  "Now: #{display(now)} - Incomings: #{incomings.map { |t| display(t) }.join(', ')}"
end

def time_parse(time)
  Time.strptime("#{time} +0200", '%m/%d/%Y %H:%M:%S %:z') + 7 * 60 * 60
end

def display(line)
  "<#{line[0].strftime('%H:%M')}> #{line[1]}"
end
