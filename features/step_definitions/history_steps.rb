Given(/^the following events exist:$/) do |table|
  table.hashes.each do |e|
  	Event.new(eid: e[:eid], address_string: e[:address_string], receiver_name: e[:receiver_name], receiver: e[:receiver], datetime_sent: e[:datetime_sent], duration_setting: e[:duration_setting], active: e[:active]).save
  end
end

Then(/^I should( not)? see event (\d+)$/) do |n,arg1|
  e = Event.find_by eid: arg1
  if n then not_space = "not " else "" end
  # step "I should #{not_space}see \"#{arg1.to_s}\""
  step "I should #{not_space}see \"#{e[:datetime_sent]}\""
end

Then(/^I should see event (\d+) to (\d+)$/) do |arg1, arg2|
  (arg1..arg2).each do |eid|
    step "I should see event #{eid}"
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  if (page.body =~ /#{e1}/) && (page.body =~ /#{e2}/)
    if (page.body =~ /#{e1}/) < (page.body =~ /#{e2}/)
      true
    else
      fail "#{e1} appears after #{e2}"
    end
  elsif !(page.body =~ /#{e1}/) && !(page.body =~ /#{e1}/)
    fail "#{e1} and #{e2} not found"
  elsif !(page.body =~ /#{e1}/)
    fail "#{e1} not found"
  elsif !(page.body =~ /#{e2}/)
    fail "#{e1} not found"
  else
    fail "Unknown Error"
  end
  # fail "Unimplemented"
end

Then(/^I should see events sorted by recency$/) do
  first10 = []
  for i in 1..10
    first10 << Event.all.where(eid: i).take
  end
  sorted_events = first10.sort_by { |event| DateTime.now - DateTime.parse(event.datetime_sent.to_s) }
  # sorted_events.each do |e| puts e.datetime_sent end # For Checking
  for j in 0..(sorted_events.length-2)
    for k in (j+1)..(sorted_events.length-1)
      step "I should see \"#{sorted_events[j].datetime_sent}\" before \"#{sorted_events[k].datetime_sent}\""
    end
  end
end
