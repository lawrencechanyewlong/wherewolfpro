Feature: Select contacts for a new event
  
    As a user
    I want to select contacts
    so I can invite people to the event.
    
Background: I am already on the select contacts page
    
#    Given that I am on the select contacts page
 #   And my 10 most recently shared contacts are:
    # we don't have a contacts schema already

  
 Scenario: Contacts
  Given I am contacted in with provider "gmail"
  Then I should be on the gmail page
  Then I should see "bob@gmail.com"
  	When I check the following emails: bob_gmail.com
  And I press "Submit Contacts"
  
  
#Scenario: Preselecting the most recently shared contact
    
 #   Then I should see the contact "Alex" checkbox to be checked
    
#Scenario: list the 10 most recently shared contacts sorted by date_time_shared
    
 #   Then I should see the contact "Alex"
  #  And I should see the contact "Bob"
   # And I should see the contact "Charles"
    #And I should see the contact "Daniel"
    #And I should see the contact "Elly"
    #And I should see the contact "Frank"
    #And I should see the contact "Greg"
    #And I should see the contact "Helen"
    #And I should see the contact "Irene"
    #And I should see the contact "Jacob"
    #And I should see the list sorted by date_time_shared
    
#Scenario: flag if no contact is selected

  #  When I uncheck all contacts
 #   And click "Next"
   # Then I should see "No Contact Selected"