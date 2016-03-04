Feature: Get instructions as a first time User
  As a first time user visiting the home page,
  I want instructions on about the buttons of the home page,
  so I can understand how to use the app.
  
  
Background: 
    Given this is the first time I have logged in.
    
Scenario: First Time User
    Given I am on the home page for WhereWoof,
    Then show the intro page,
    Then I press "Got it!",
    And the intro should disappear.