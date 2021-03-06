require './test/app_helper'

class AppHelpTest < Minitest::Test
  include Rack::Test::Methods

  def app
    ExercismApp
  end

  def visit_setup_page language
    get "/help/setup/#{language}"
    assert last_response.body.include?(language), "Cannot find setup page for #{language}."
    assert last_response.body.include?("Installing"), "Setup page for #{language} doesn't say 'Installation'."
    assert last_response.status == 200, "Did not get a 200 OK on setup page for #{language}"
  end

  def test_language_setup_pages
    Exercism.current.each do |language|
      visit_setup_page language
    end
  end

  def test_usupported_language_returns_not_found
    get '/help/setup/fortran'
    assert last_response.status == 404
  end
end
