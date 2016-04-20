And /^I press on the image "(.*)"$/ do |img|
	page.should have_xpath("//img[@id=\"#{img}\"]")
	step "I click on image #{img}"
end