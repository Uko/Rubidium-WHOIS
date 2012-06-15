Feature: Handling errors of whois library in user-friendly way
  Visitors should be taken to the search page,
  shown some message and sometimes provided with already entered domain name they've searched for.
  So that they can continue to use the app and not be frustrated with an error page.
  
  Scenario: ConnectionError
    Given Whois throws "ConnectionError"
    When I query "google.com.ua" domain
    Then I should be redirected to "Search page"
    And I should see "alert": "There was a problem with a connection to WHOIS server. Please try again in a moment"
    And input field "domain_request" should contain "google.com.ua"

  Scenario: Timeout Error
    Given Whois throws "Timeout Error"
    When I query "google.com.ua" domain
    Then I should be redirected to "Search page"
    And I should see "alert": "The WHOIS server was not responding for a long time. Please try again in a moment"
    And input field "domain_request" should contain "google.com.ua"
    
  Scenario: ServerNotFound Error
    Given Whois throws "ServerNotFound Error"
    When I query "google.com.ua" domain
    Then I should be redirected to "Search page"
    And I should see "error": "The domain google.com.ua is illegal or not supported with our service"