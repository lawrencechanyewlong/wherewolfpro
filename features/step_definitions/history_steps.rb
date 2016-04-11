Given(/^the following events exist:$/) do |table|
  table.hashes.each do |e|
  	Event.new(eid: e[:eid], address_string: e[:address_string], receiver_name: e[:receiver_name], receiver: e[:receiver], datetime_sent: e[:datetime_sent], duration_setting: e[:duration_setting], active: e[:active]).save
  end
end

And(/^I press event (\d+)$/) do |arg1|
  step "I follow \"eid:#{arg1.to_s}:\""
end

Then(/^I should( not)? see event (\d+)$/) do |n,arg1|
  e = Event.find_by eid: arg1
  if n then not_space = "not " else "" end
  step "I should #{not_space}see \"eid:#{arg1.to_s}:\""
end

And (/^I should see (.*) of event (\d+)$/) do |field,arg1|
  e = Event.where(eid: arg1).first
  step "I should see \"#{e[field]}\""
end

Then(/^I should see event (\d+) to (\d+)$/) do |arg1, arg2|
  (arg1..arg2).each do |eid|
    step "I should see event #{eid}"
  end
end

Then /I should see event (.*) before event (.*)/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  if (page.body =~ /eid:#{e1}:/) && (page.body =~ /eid:#{e2}:/)
    if (page.body =~ /eid:#{e1}:/) < (page.body =~ /eid:#{e2}:/)
      true
    else
      fail "eid:#{e1} appears after eid:#{e2}"
    end
  elsif !(page.body =~ /eid:#{e1}:/) && !(page.body =~ /eid:#{e1}:/)
    fail "eid:#{e1}: and eid:#{e2}: not found"
  elsif !(page.body =~ /eid:#{e1}:/)
    fail "eid:#{e1} not found"
  elsif !(page.body =~ /eid:#{e2}:/)
    fail "eid:#{e1}: not found"
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
      step "I should see event #{sorted_events[j].eid} before event #{sorted_events[k].eid}"
    end
  end
end
