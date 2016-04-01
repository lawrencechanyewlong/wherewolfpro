Feature: Send a specified destination
  
  As a user
  so that I can meet at a location with my friends
  I want to share a specific location
  
Background: background
  Given I am on the select destination page
  Then I should see "Select Destination"

Scenario: navigate to next page
  
  When I follow "Next"
  Then I should be on the select contacts page

# Scenario: send a location of a new destination
  
#   And I click on map
#   Then I enter "Berkeley" into the search bar
#   And I press "Search_Submit"
#   Then I press "Submit"
#   Then I should be on select contact page

