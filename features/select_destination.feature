Feature: Send a specified destination
  
  As a user
  so that I can meet at a location with my friends
  I want to share a specific location
  
Background: I have saved destinations
  Given I am on destination page
  Given the following saved destinations exist:
    | name      | address_lat   | address_lng   |
    | test1     | 1.0           | 1.4           |
    | test2     | 1.2           | 1.5           |
    | test3     | 1.3           | 1.6           |
  
Scenario: see a map
  Then I should see "Map"

@wip
Scenario: send a location of a saved destination
  
  And I follow "test1"
  Then I should be on the select contacts page
  
@wip
Scenario: send a location of a new destination
  
  And I click on map
  Then I enter "Berkeley" into the search bar
  And I press "Search_Submit"
  Then I press "Submit"
  Then I should be on select contact page

