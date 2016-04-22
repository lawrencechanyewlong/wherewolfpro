Feature: User info
  As a user,
  I want to log in,
  so I can access the features of the site.
 

Scenario: A user logs in with AppleID
  Given I am on the home page,
  And I press "Log in with AppleID"
  Then I should not see "Log in with AppleID"

Scenario: A user creates an account
  Given I am on the new user page
  When I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "Submit info"
  Then I should be on the login page
  Then I should see "user created!"
  

Scenario: A user forgets to fill in info
  Given I am on the new user page
  When I fill in "Email" with "user@berkeley.edu"
  And I press "Submit info"
  Then I should be on the new user page
  And I should see "entry missing"



Scenario: A user cannot make duplicates
  Given I am on the new user page
  When I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "Submit info"
  Then I am on the new user page
  When I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "Submit info"
  Then I should see "email already taken"
  
Scenario: A user fails to log in
  Given I am on the login page
  And I press "login"
  Then I should be on the login page
  Then I should see "the email is not in our database"
  
Scenario: A user logs in and is able to log out
  Given I am on the new user page
  When I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "Submit info"
  Then I should be on the login page
  When I fill in "Email" with "user@berkeley.edu"
  And I fill in "Password" with "password"
  And I press "login"
  Then I should be on the welcome page
  Then I follow "Logout"
  Then I should be on the home page