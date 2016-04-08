Feature: Create the event after all the selections
  
  As a user
  so that I can share my location with my friends
  I want to create a link to my event
  
Background:
  
  Given I am on the summary page
  
@wip
Scenario: Create a link
  
  And I click the "Send" button
  Then I should see send an email
  And there should be a link in it