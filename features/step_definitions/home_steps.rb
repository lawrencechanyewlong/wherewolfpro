Then /^I should see the image "(.+)"$/ do |image|
    page.should have_xpath("//img[@id=\"#{image}\"]")
end

And  /^I log in$/ do
	step "I am on the new user page"
	step "I fill in \"Email\" with \"user@berkeley.edu\""
  	step "I fill in \"Password\" with \"password\""
  	step "I press \"Submit info\""
	step "I should be on the login page"
	step "I fill in \"Email\" with \"user@berkeley.edu\""
	step "I fill in \"Password\" with \"password\""
	step "I press \"login\""
end