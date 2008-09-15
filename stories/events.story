Story: Event related things

  As a visitor
  I want to visit the events pages
  So that I can see all the cool stuff
  
  Scenario: not logged in
    Given I am not logged in
      And a previous event exists
    When I view the past events pages from an iphone
    Then I see the page
