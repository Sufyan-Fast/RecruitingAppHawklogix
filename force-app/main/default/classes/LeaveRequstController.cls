public with sharing class LeaveRequstController {
    @AuraEnabled(cacheable=true)
    public static List<Leave_Request__c> getMyLeaves(Id recordId){
        try {
            List<Leave_Request__c> myLeaves=new List<Leave_Request__c>();
            myLeaves=[SELECT Id,Name,Start_Date__c,End_Date__c,Reason__c,Leave_Status__c FROM Leave_Request__c 
            where Employee__c =:recordId
            ORDER BY CreatedDate DESC];
            System.System.debug(myLeaves);
            return myLeaves;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Leave_Request__c> getLeaveRequests(Id recordId){
        try {
            List<Leave_Request__c   > myLeaves=new List<Leave_Request__c>();
            myLeaves=[SELECT Id,Name,Start_Date__c,End_Date__c,Reason__c,Leave_Status__c FROM Leave_Request__c
            where Employee__c =:recordId
            ORDER BY CreatedDate DESC];
            System.System.debug(myLeaves);
            return myLeaves;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}