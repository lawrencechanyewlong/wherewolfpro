require 'capybara/poltergeist'
require 'phantomjs'

When /^I move the slider for "(.*)" to "(.*)"/ do |slider, value| 
   Phantomjs.path # Force install on require
   Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:phantomjs => Phantomjs.path, :phantomjs_options => ['--ssl-protocol=any']})
   end
   Capybara.javascript_driver = :poltergeist
   Capybara.current_driver = Capybara.javascript_driver
   Capybara.ignore_hidden_elements = false
   visit '/event/select_duration'
   page.find("##{slider}")
   page.execute_script("s = $('##{slider}')")
   page.execute_script("s.slider('setValue', #{value});")
   page.execute_script("s.trigger('change');")
end

When /^(?:|I )choose a radio button "([^"]*)"$/ do |field|
   page.find_by_id(field).trigger('click')
end

Then /^the slider for "(.*)" should be at "(.*)"/ do |slider, value|
   page.execute_script("s = $('##{slider}')")
   page.evaluate_script("s.slider('getValue');").should == value.to_i
end

And /^I should be out of poltergeist/ do
   Capybara.javascript_driver = :rack_test
   Capybara.current_driver = Capybara.javascript_driver
end

Then /^(?:|I )should again be on (.+)$/ do |page_name|
   Capybara.javascript_driver = :rack_test
   Capybara.current_driver = Capybara.javascript_driver
   current_path = URI.parse(current_url).path
   if current_path.respond_to? :should
      current_path.should == path_to(page_name)
   else
      assert_equal path_to(page_name), current_path
   end
end