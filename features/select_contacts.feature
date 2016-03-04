Feature: Select contacts for a new event
  
    As a user
    So that I can select which contacts to share my location easily
    I want to select from a list of recently shared contacts
    
Background: I am already on the select contacts page
    
    Given that I am on the select contacts page
    And my 10 most recently shared contacts are:
    | name    | date_time_shared |
    | Alex    | 1                |
    | Bob     | 2                |
    | Charles | 3                |
    | Daniel  | 4                |
    | Elly    | 5                |
    | Frank   | 6                |
    | Greg    | 7                |
    | Helen   | 8                |
    | Irene   | 9                |
    | Jacob   | 10               |
  
Scenario: Preselecting the most recently shared contact
    
    Then I should see the contact "Alex" checkbox to be checked
    
Scenario: list the 10 most recently shared contacts sorted by date_time_shared
    
    Then I should see the contact "Alex"
    And I should see the contact "Bob"
    And I should see the contact "Charles"
    And I should see the contact "Daniel"
    And I should see the contact "Elly"
    And I should see the contact "Frank"
    And I should see the contact "Greg"
    And I should see the contact "Helen"
    And I should see the contact "Irene"
    And I should see the contact "Jacob"
    And I should see the list sorted by date_time_shared
    
Scenario: flag if no contact is selected

    When I uncheck all contacts
    And click "Next"
    Then I should see "No Contact Selected"