require_relative '../lib/redmine'

file_lines = File.readlines(ARGV[0]).map { |l| l.delete "\n"  }

server_url = file_lines[0]
user = file_lines[1].split(';')[0]
password = file_lines[1].split(';')[1]
project_name = file_lines[2]
entries = []

file_lines.each_with_index do |line, index|
  next if index < 3

  entry = line.split ';'
  entries << { 
    date: entry[0], 
    hours: entry[1], 
    activity: entry[2], 
    comment: entry.fetch(3, ''), 
    issue: entry.fetch(4, '') 
  }
end

redmine = Redmine.new server_url
redmine.login user, password
entries.each { |e| redmine.log_activity(project_name, e) }
