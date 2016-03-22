When /^I move the slider for "Until This Time" to "(.*)"/ do |value| 
   pending
   page.execute_script "s=$('#slider1');"
   page.execute_script "s.slider('setValue', #{value});"
end