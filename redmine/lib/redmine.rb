require_relative './entry'
require 'capybara/dsl'

class Redmine
  attr_reader :server_url, :session

  def initialize(server_url)
    Capybara.default_wait_time = 15
    @session = Capybara::Session.new(:selenium)
    @server_url = server_url
  end

  def login(user, password)
    session.visit server_url
    session.fill_in 'Login', with: user
    session.fill_in 'Password', with: password
    session.click_on 'Login'
  end

  def log_activity(project_name, args)
    entry = Entry.new(args)

    session.visit server_url

    session.click_on 'Projects'
    session.click_on project_name

    session.click_on 'Report'

    session.click_on 'Log time'
    session.fill_in 'Issue', with: entry.issue
    session.fill_in 'Date', with: entry.date
    session.fill_in 'Hours', with: entry.hours
    session.fill_in 'Comment', with: entry.comment
    session.select entry.activity, from: 'Activity'
    session.click_on 'Save'
    
    log(entry)
  end

  private

    attr_reader :user_name, :user_password

    def log(entry)
      puts entry.to_s
    end
end
