When /I (un)?check the following emails: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |rate|
    if uncheck
      uncheck "info_#{rate}"
    else
      check "info_#{rate}"
    end
  end
end