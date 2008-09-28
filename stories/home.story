Story: Viewing the home page

  As a visitor
  I want to visit the home page
  So that I can see all the cool stuff
  
  Scenario: not logged in
    Given I am not logged in
    When I view the home page
    Then I see the page

  Scenario: viewing / on a mobile
    Given I am not logged in
    When I view the home page from an iphone
    Then I am redirected to the mobile page
    
  Scenario: viewing / on a mobile with redirect-to-mobile=no
    Given I am not logged in
    When I view the home page from an iphone specifying redirect-to-mobile=no
    Then I am not redirected to the mobile page
    And I see the page

  Scenario: viewing the mobile version with an upcoming event, a past event and a post
    Given I am not logged in
      And an upcoming event exists
      And a past event exists
      And a post exists
    When I view the mobile version of the home page
    Then I see the page

  Scenario: viewing the mobile version without any events or posts
    Given I am not logged in
      And no events or posts exist
    When I view the mobile version of the home page
    Then I see the page
