Given(/^the following events exist:$/) do |table|
  table.hashes.each do |e|
  	Event.new(id: e[:id], address_string: e[:address_string], receiver_name: e[:receiver_name], receiver: e[:receiver], datetime_sent: e[:datetime_sent], duration_setting: e[:duration_setting], active: e[:active]).save
  end
end

And(/^I press event (\d+)$/) do |arg1|
  step "I follow \"eid:#{arg1.to_s}:\""
end

Then(/^I should( not)? see person (\d+)$/) do |n,arg1|
  e = Event.find_by id: arg1
  if n then not_space = "not " else "" end
  step "I should #{not_space}see \"Person#{arg1.to_s}\""
end

And (/^I should see (.*) of event (\d+)$/) do |field,arg1|
  e = Event.where(id: arg1).first
  step "I should see \"#{e[field]}\""
end

Then(/^I should see person (\d+) to (\d+)$/) do |arg1, arg2|
  (arg1..arg2).each do |id|
    step "I should see person #{id}"
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
    fail "#{e2} not found"
  else
    fail "Unknown Error"
  end
  # fail "Unimplemented"
end

Then(/^I should see events sorted by recency$/) do
  first10 = []
  for i in 1..10
    first10 << Event.all.where(id: i).take
  end
  sorted_events = first10.sort_by { |event| DateTime.now - DateTime.parse(event.created_at.to_s) }
  # sorted_events.each do |e| puts e.datetime_sent end # For Checking
  for j in (sorted_events.length-1)..1
    for k in (j-1)..0
      step "I should see \"#{sorted_events[k].receiver_name}\" before \"#{sorted_events[j].receiver_name}\""
    end
  end
end
