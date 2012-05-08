Given /^I have queried "(.*?)" domain$/ do |arg1|
  visit("/#{arg1}")
end

Then /^I should see "(.*?)" as a header$/ do |arg1|
  page.all("h1,h2,h3,h4,h5,h6").any? {|tag| tag.should have_content(arg1)}
end