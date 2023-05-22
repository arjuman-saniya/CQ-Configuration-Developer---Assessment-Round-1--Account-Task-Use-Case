public class AccountTriggerHandler {
    public static void handleAccountTrigger(List<Account> newList, Map<Id, Account> oldMap) {
        List<Task> newTasks = new List<Task>();
        List<Task> tasksToUpdate = new List<Task>();

        for (Account acc : newList) {
            if (Trigger.isInsert) {
                // Create a new task for each inserted account
                Task newTask = new Task();
                newTask.Subject = 'Review Account - ' + acc.AccountNumber;
                newTask.ActivityDate = System.today().addDays(7);
                newTask.OwnerId = acc.OwnerId;
                newTask.Status = 'Not Started';
                newTasks.add(newTask);
            }

            if (Trigger.isUpdate && acc.Active__c && oldMap.get(acc.Id).Active__c != acc.Active__c) {
                // Account checkbox changed to true (checked)
                // Find the associated task and update its status to "Completed"
                List<Task> accountTasks = [SELECT Id, Status FROM Task WHERE WhatId = :acc.Id];

                for (Task task : accountTasks) {
                    if (task.Status != 'Completed') {
                        task.Status = 'Completed';
                        tasksToUpdate.add(task);
                    }
                }
            }
        }

        if (!newTasks.isEmpty()) {
            insert newTasks;
        }

        if (!tasksToUpdate.isEmpty()) {
            update tasksToUpdate;
        }
    }
}

