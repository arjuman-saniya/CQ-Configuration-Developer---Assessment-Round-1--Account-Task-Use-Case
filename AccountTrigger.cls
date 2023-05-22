trigger AccountTrigger on Account (after insert, after update) {
    AccountTriggerHandler.handleAccountTrigger(Trigger.new, Trigger.oldMap);
}