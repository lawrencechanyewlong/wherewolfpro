Then /^(?:|I )should see the map rendered$/ do
  page.should have_css('div#map')   
end


