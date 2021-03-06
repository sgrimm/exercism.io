require './test/test_helper'
require 'app/help/setup'
require 'exercism/curriculum' # I hate the dependencies here

class AppHelpSetupTest < Minitest::Test
  def with_stubbed_languages(&block)
    Exercism.stub(:languages, [:ruby]) do
      Exercism.stub(:upcoming, ["PHP"]) do
        block.call
      end
    end
  end

  def test_current_language
    with_stubbed_languages do
      language = App::Help::Setup.new('Ruby')
      assert_equal 'Ruby', language.name
      assert_equal 'ruby', language.topic
      refute language.not_found?
    end
  end

  def test_upcoming_language
    with_stubbed_languages do
      language = App::Help::Setup.new('PHP')
      assert_equal 'PHP', language.name
      assert_equal 'coming-soon', language.topic
      refute language.not_found?
    end
  end

  def test_no_such_language
    with_stubbed_languages do
      language = App::Help::Setup.new('Fortran')
      assert_equal 'Fortran', language.name
      assert_equal '404', language.topic
      assert language.not_found?
    end
  end
end
