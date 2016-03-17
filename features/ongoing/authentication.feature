Feature: User info
  As a user,
  I want to log in,
  so I can access the features of the site.
 
@wip
Scenario: a user can log into google
  Given I am signed in with provider "google_oauth2"
  Then I should be on the home page
  And I should see "events"
  
@wip
Scenario: a user can log out from google
  Given I am signed in with provider "google_oauth2"
  Then I should be on the home page
  And I should see "events"
  Then I follow "logout"
  Then I should be on the home page
  And I should see "user_login"
  
