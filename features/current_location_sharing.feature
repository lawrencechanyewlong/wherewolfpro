Feature: Share Current location with other people
  
  As a user
  so that they will know my location as I am driving to our meeting location 
  I want to share my location with my friends
    
Background: contacts have been added to database
  
  Given the following contacts exist:
  | name                   | handphone number | email address         |userid            |
  | Jim                    | 5107101234       | jimparsons@gmail.com  |12345677          |

Scenario: share a contact with a friend
  
  When I am on the select contacts page
  Then I select on "Jim"
  And I add a message "Hi Jim! This is my location."
  And I select a duration of 12 hours
  Then I click on "send"
  Then I click on "confirm"
  Then I should see "Location Shared"
  


