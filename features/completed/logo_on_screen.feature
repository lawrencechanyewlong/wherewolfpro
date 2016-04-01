Feature: display Wherewoof logo on screen 
  
  As a CityDogShare Founder
  So that I can attract traffic to CityDogShare
  I want to increase awareness of CityDogShare
  
Scenario: Start the application
  
  Given I log in
  Then I should be on the welcome page
  Then I should see the image "wherewoof_logo"
  And I should see the image "citydogshare_logo"
