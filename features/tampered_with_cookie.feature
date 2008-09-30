Story: Gracefully handing tampered cookies

  As a user with a tampered cookie
  I want to not be shown a rude error page
  So that I can join in the webjam fun
  
  Scenario: user with tampered cookie
    Given I am naughty
    When I view the home page with a tampered cookie
    Then I don't see an exception
