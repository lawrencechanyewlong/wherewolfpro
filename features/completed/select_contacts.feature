Feature: Select contacts for a new event
  
  As a user
  I want to select contacts
  so I can invite people to the event.
    
Background: I am a user who wants his contacts
  Given I am on the new user page
  When I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "Submit info"
  Then I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "login"

Scenario: Making a contact and being able to view it.
  
  Given I am on the select contacts page
  And I fill in "name" with "user"
  And I fill in "email" with "user@berkeley.edu"
  And I press "Add Contact"
  Then I should be on the select contacts page
  And I should see "user@berkeley.edu"
  And I should see "user created"
  When I check the following emails: user@berkeley.edu
  And I press "Next"
  Given I am on the summary page
  Then I should see "user@berkeley.edu"
  
  
Scenario: Failing to make a contact
  
  Given I am on the select contacts page
  And I press "Add Contact"
  Then I should see "Invalid"