Feature: Viewing post pages

  In order to absorb Lachlan's deep insights into man and machine
  I should be able to visit pages and pages and pages of blog posts
  
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
