Feature: Viewing the about page

  In order to read all about Webjam
  I should be able to visit the about page
  
  Scenario: about page with past events from an iphone
    Given there is a past event
    When I view the mobile about page
    Then I see the page

  Scenario: about page with upcoming events from an iphone
    Given there is an upcoming event
    When I view the mobile about page
    Then I see the page
