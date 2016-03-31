Feature: display Wherewoof logo on screen 
  
  As a CityDogShare Founder
  So that I can attract traffic to CityDogShare
  I want to increase awareness of CityDogShare
  
Scenario: Start the application
  
  Given I am on the home page
  Given PENDING
  Then I should be on the home page
  Then I should see the image "wherewoof_logo"
  And I should see the image "citydogshare_logo"
