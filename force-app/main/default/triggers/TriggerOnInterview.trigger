trigger TriggerOnInterview on Interview__c (after insert,after update) {
    
    if(trigger.isAfter && trigger.isInsert)
    {
    HandlerInterviewTrigger.handleInsertOperation(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate && StopRecursion.isFirstTime)
    {
    HandlerInterviewTrigger.handleUpdateOperation(trigger.new,trigger.old);
    }

}