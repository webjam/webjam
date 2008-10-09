Feature: Gracefully handing tampered cookies

  In order to join in the webjam fun
  I should be able to browse webjam with a tampered cookie
  
  Scenario: user with tampered cookie
    Given I am naughty
    When I view the home page with a tampered cookie
    Then I don't see an exception
