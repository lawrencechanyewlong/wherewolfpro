Feature: confirm event
  
  As a user of the wherewoof app
  So that I can confirm my selections
  I want to see my previous choices
  
@wip
Scenario: view confirmation after selections
  
  Given I have selected "2799 Bancroft Way, Berkeley, CA 94704, USA" on the select destination page
  And I have selected "Ken" on the select contacts page
  And I have selected "duration" on the select duration page
  And I have selected "message" on the message page
  Then I should see "2799 Bancroft Way, Berkeley, CA 94704, USA" on the confirm page
  Then I should see "Ken" on the confirm page
  Then I should see "duration" on the confirm page
  Then I should see "message" on the confirm page