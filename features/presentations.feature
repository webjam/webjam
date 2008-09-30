Story: Viewing event presentations

  As a visitor
  I want to view the presentations for an event
  So that I can relive the moments
  
  Scenario: viewing an event's presentations page
    Given I am not logged in
    When I view an events presentations page
    Then I am redirected to the event

  Scenario: view an event presentation page
    Given I am not logged in
    When I view an event presentation page
    Then I see the page
    
  Scenario: view a mobile event presentation page
    Given I am not logged in
    When I view a mobile event presentation page
    Then I see the page
