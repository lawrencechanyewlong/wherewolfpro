Feature: Emailing function

    As a user of the wherewoof app
    I should be able to use the wherewoof event page
    so I can send a notifying email to all contacts selected.

    

Scenario: I send an email and the contact was submitted
     Given I am on the new user page
    When I fill in "Email" with "user@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Submit info"
     Then I should be on the login page
    Then I should see "user created!"
  
    Given I am on the select contacts page
    And I fill in "email" with "user@berkeley.edu"
    And I press "Add New Contact"
    Given I am on the summary page
    When I follow "Send"
    Then I should be on the send mail page

 

Scenario: I send an email and there is no contact
     Given I am on the new user page
    When I fill in "Email" with "user@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Submit info"
     Then I should be on the login page
    Then I should see "user created!"
  
    Given I am on the select contacts page
    And I fill in "email" with "user@berkeley.edu"
    And I press "Add New Contact"
    Given I am on the summary page
    When I follow "Send"
