Story: Viewing the about page

  As a visitor
  I want to visit the about page
  So that I can read all about Webjam
  
  Scenario: about page with past events from an iphone
    Given there is a past event
    When I view the about page from my iphone
    Then I see the page

  Scenario: about page with upcoming events from an iphone
    Given there is an upcoming event
    When I view the about page from my iphone
    Then I see the page
