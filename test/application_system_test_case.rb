require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  def visit_with_http_auth(path)
    username = 'movie'
    password = 'night'
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:# 
    {Capybara.current_session.server.port}#{path}"
  end
end
