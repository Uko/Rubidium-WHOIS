Given /^I have queried "(.*?)" domain$/ do |arg1|
  request = arg1.split('.').reverse.join('/')
  visit("/domains/#{request}")
end

Then /^I should see "(.*?)" as a header$/ do |arg1|
  page.all("h1,h2,h3,h4,h5,h6").any? {|tag| tag.should have_content(arg1)}
end

Given /^Whois throws "(.*?)"$/ do |arg1|
  case arg1
  when "ConnectionError"
    Whois.should_receive(:query).and_raise(Whois::ConnectionError)
  when "Timeout Error"
    Whois.should_receive(:query).and_raise(Timeout::Error)
  when "ServerNotFound Error"
    Whois.should_receive(:query).and_raise(Whois::ServerNotFound)
  end
end

When /^I query "(.*?)" domain$/ do |arg1|
  request = arg1.split('.').reverse.join('/')
  visit("/domains/#{request}")
end

Then /^I should be redirected to "(.*?)"$/ do |arg1|
  case arg1
  when "Search page"
    page_path = root_path
  end
  URI.parse(current_url).path.should == page_path
end

Then /^I should see "(.*?)": "(.*?)"$/ do |selector, msg|
  page.find_by_id(selector).should have_content(msg)
end

Then /^input field "(.*?)" should contain "(.*?)"$/ do |field,val|
  page.find_field(field).value.should == val
end