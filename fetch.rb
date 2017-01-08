require 'nokogiri'
require 'open-uri'

def fetch
  url = "https://gamesdonequick.com/schedule"
  doc = Nokogiri::HTML(open(url))
  lines = []
  current_line = {}
  doc.css('#runTable tbody tr:not(:last-child)').each do |tr|
    if tr['class'] != 'second-row'
      current_line[:time] = tr.elements[0].text
      current_line[:game] = tr.elements[1].text
      current_line[:runners] = tr.elements[2].text
      current_line[:setup] = tr.elements[3].elements[0].text if tr.elements[3].elements[0]
    else
      current_line[:estimate] = tr.elements[0].elements[0].text
      current_line[:type] = tr.elements[1].text

      lines << current_line
      current_line = {}
    end
  end

  times = lines.map do |l|
    [time_parse(l[:time]), l[:game]]
  end

  now = times.select { |t| t[0] < Time.now + 1 * 60 * 60 }.last
  incomings = times.select { |t| t[0] > Time.now + 1 * 60 * 60 }[0..5]
  "Now: #{display(now)} | Incomings: #{incomings.map { |t| display(t) }.join(', ')}"
end

def time_parse(time)
  Time.parse(time) + 1 * 60 * 60
end

def display(line)
  "<#{line[0].strftime('%H:%M')}> #{line[1]}"
end
