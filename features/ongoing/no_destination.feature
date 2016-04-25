Feature: not choosing any destination
  As a user
  So that I can share my current location without destination
  I do not want to share any specific location
  
Scenario: Not choosing any location
  Given I am on the select destination page
  Then I should see "or press Next without placing a marker on the map."