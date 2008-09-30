Story: Updating your account details

  As a user
  I want to edit and update my personal details
  So that I can show the world how cool I am
  
  Scenario: viewing the account page
    Given I am logged in
    When I view the account page
    Then I see the page

  Scenario: updating account details
    Given I am logged in
    When I update my account details
    Then my account details are updated
    And I am redirected to the account page
