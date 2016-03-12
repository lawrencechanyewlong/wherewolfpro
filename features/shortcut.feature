Feature:
 As a user, 
I want the shortcuts tab to take me to the top events by times used, 
so that I can select a previously entered event at the top easily.


# Background:
#   Given the following events exist:
#   | name                   | times |
#   | Mom's house            | 8     |
#   | Dad's house            | 14    |

# Scenario: Dad's house is before Mom's house in the list.
#   Given I am on the home page,
#   And I press "Shortcut",
#   Then I am on the shortcut page, 
#   And "Dad's house" is before "Mom's house."
  
#   Scenario: Clicking Dad's house gives me the event.
#     Given I am on the home page,
#     And I press "Shortcut",
#     Then I am on the shortcut page,
#     And I press "Dad's House",
#     Then I am on the event page for "Dad's House"
  
  
