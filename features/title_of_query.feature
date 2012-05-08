Feature: Domain name in header
  To see to which domain the whois info belongs,
  visitors should see the requested domain in header.
  
  Scenario: unikernel.net
      Given I have queried "unikernel.net" domain
      Then I should see "unikernel.net" as a header