@isTest
public class AccountTriggerHandlerTest {
    @isTest
    public static void testAccountTriggerHandler() {
        // Create test data
        Account acc = new Account(Name = 'Test Account', OwnerId = UserInfo.getUserId());
        insert acc;

        // Insert trigger
        Test.startTest();
        AccountTriggerHandler.handleAccountTrigger(new List<Account>{acc}, new Map<Id, Account>());
        Test.stopTest();

        // Verify the created task
        List<Task> tasks = [SELECT Subject, ActivityDate, OwnerId, Status FROM Task WHERE WhatId = :acc.Id];
        System.assertEquals(1, tasks.size());
        Task createdTask = tasks[0];
        System.assertEquals('Review Account - ' + acc.AccountNumber, createdTask.Subject);
        System.assertEquals(System.today().addDays(7), createdTask.ActivityDate);
        System.assertEquals(acc.OwnerId, createdTask.OwnerId);
        System.assertEquals('Not Started', createdTask.Status);

        // Update account checkbox to true (checked)
        acc.Active__c = true;
        Test.startTest();
        AccountTriggerHandler.handleAccountTrigger(new List<Account>{acc}, new Map<Id, Account>{acc.Id => acc});
        Test.stopTest();

        // Verify the updated task
        tasks = [SELECT Status FROM Task WHERE WhatId = :acc.Id];
        System.assertEquals(1, tasks.size());
        System.assertEquals('Completed', tasks[0].Status);
    }
}