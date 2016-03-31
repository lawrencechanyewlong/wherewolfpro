Given /^I have selected "(.*)" on (.+)$/ do |selection, page_name|
  steps %Q{
    Given I am on #{page_name}
  } 
  pending
end

Then /^I should see "(.*)" on (.+)$/ do |results, page_name|
  pending
end




