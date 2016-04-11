Feature: Reset all forms when click on home logo

    As a user, 
    so that I can intuitively reset all input, 
    I want to click the logo to reset my input and go to the home page

@wip
Scenario: I want to reset my form input
    Given I am on the summary page page
    And I press on the image "wherewoof_logo"
    Then I should be on the home page
    And I should not have any input
