Story: Event related things

  As a visitor
  I want to visit the events pages
  So that I can see all the cool stuff
  
  Scenario: not logged viewing the past events page from an iphone
    Given I am not logged in
      And there is a past event
    When I view the mobile past events page
    Then I see the page

  Scenario: not logged viewing the event page for a past event
    Given I am not logged in
    When I view the event page for a past event
    Then I see the page

  Scenario: not logged viewing the event page for an upcoming event
    Given I am not logged in
    When I view the event page for an upcoming event
    Then I see the page

  Scenario: trying to view an unpublished event
    Given I am not logged in
    When I view the event page for an unpublished event
    Then I receive a 404 not found
