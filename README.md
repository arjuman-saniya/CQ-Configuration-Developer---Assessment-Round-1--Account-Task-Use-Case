# CQ-Configuration-Developer---Assessment-Round-1--Account-Task-Use-Case
This repository contains the data of CQ Configuration Developer - Assessment Round 1- Account Task Use Case
Here is the steps i have mentioned to achieve the assessment task 

Steps 1 -

Create a Checkbox Field in Account Object 
 -Go to the Object Manager in Salesforce Setup.
 -Find the Account object and open it.
 -Create a new field called "Active" with the data type "Checkbox."
 -Save

Steps 2- 

 write a trigger on after insert event to perform 
 - In the trigger code, write logic to create a Salesforce Task when a new Account record is added. you can see above in apex trigger file.
   a- Set the Subject of the Task as "Review Account- [Account Number]".
   b-Set the Due Date of the Task as one week from the current date (e.g., System.today() + 7).
   c-Set the Assigned To field of the Task as the owner of the Account (use the OwnerId field).
   d- Set the Status of the Task as "Not Started."

Steps 3- 
 Create a Permission Set:
-Go to the Permission Sets page in Salesforce Setup.
-Create a new permission set called "CQ Account Admin."
-In the permission set, grant the "Complete Task" permission on the Account object.
-Assign the appropriate users or profiles to this permission set.

steps 4 - 
  - Here I  want the Task to be automatically completed when the Account is activated, you can create a workflow or process builder on the Task object.
      Define the condition to check if the related Account's "Active" field is changed to "True."

