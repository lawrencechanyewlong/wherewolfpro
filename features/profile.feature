Feature:
As a User, 
I want to tap on my profile picture to take me to my personal profile page,
so that I can access my previous events and my number of shares.

Background:
  Given the user has events "Work" and "home"
  And he has 12 shares
  
Scenario: Showing the shares and the events
  Given I am on the homepage,
  and I press "Profile picture",
  then my number of shares should be 12,
  and my events should be "Work" and "home".