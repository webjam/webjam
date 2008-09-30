Story: Viewing post pages

  As a visitor
  I want to visit pages and pages and pages of blog posts
  So that I absorb Lachlan's deep insights into man and machine
  
  Scenario: viewing a post when logged in
    Given I am logged in
    When I view the post page
    Then I see the page

  Scenario: viewing a post when not logged in
    Given I am not logged in
    When I view the post page
    Then I see the page

  Scenario: viewing a mobile post when logged in
    Given I am logged in
    When I view the mobile post page
    Then I see the page
  
  Scenario: viewing a mobile post when not logged in
    Given I am logged in
    When I view the mobile post page
    Then I see the page
