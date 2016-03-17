Feature: keep saved and sent locations 
  
  As a user
  So that I can access my frequently used locations easily
  I want to see my saved and sent locations
  
Background: locations have been added to database 
  
  Given the following locations exist:
    | longitude      | latitude   | date_time_shared   | location_name  | saved?    |
    | 1              | 2          | 3                  | location_1     | true      |
    | 4              | 5          | 6                  | location_2     | true      |
    | 7              | 8          | 9                  | location_3     | false     |
    | 10             | 12         | 13                 | location_4     | false     |
    | 14             | 15         | 16                 | location_5     | false     |

  And I am on the Wherewoof home page

@wip  
Scenario: saved locations in profile page
  
  When I am on the profile page     
  Then I should see location_1
  Then I should see location_2
  Then I should see location_3
  Then I should see location_4
  Then I should see location_5

@wip
Scenario: recent and saved locations in My Locations page
  
  When I press "New Event"
  And I press "My Locations"
  Then I should see location_1
  Then I should see location_2
  Then I should see location_3
  Then I should see location_4
  Then I should see location_5
  
