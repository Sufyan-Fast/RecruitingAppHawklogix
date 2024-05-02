public class HandlerInterviewTrigger {
    
    public static void handleInsertOperation(List<Interview__c> newInterviewList)
    {
        Interview__c newInterviewRecord = newInterviewList[0];
        if(newInterviewRecord.Interview_Location__c == 'Online')
        {
        HelperInterviewTrigger.createMSteamsRequest(newInterviewRecord);
        }
    }
    
    Public static void handleUpdateOperation(List<Interview__c> newInterviewList, List<Interview__c> oldInterviewList)
    {
        
        Interview__c newInterviewRecord = newInterviewList[0];
        Interview__c oldInterviewRecord = oldInterviewList[0];
        System.debug('newInterviewRecord=>' + newInterviewRecord.Interview_Date_Time__c);
        System.debug('oldInterviewRecord=>' + oldInterviewRecord.Interview_Date_Time__c);
       if((newInterviewRecord.Interview_Location__c == 'Online') &&
          (newInterviewRecord.Interview_Location__c == 'Online' && (newInterviewRecord.Interview_Date_Time__c != oldInterviewRecord.Interview_Date_Time__c  ||
          newInterviewRecord.Interview_End_Date_Time__c != oldInterviewRecord.Interview_End_Date_Time__c)))
        {
        HelperInterviewTrigger.createMSteamsRequest(newInterviewRecord);

    }
  
}
}