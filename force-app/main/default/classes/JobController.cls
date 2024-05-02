public with sharing class JobController {
    
    @AuraEnabled(cacheable = true)
    public static Id createJobRecord(String name, String email, String phone, String referredBy, String coverLetter) {
        try {
        
            Job_Application__c jobRecord = new Job_Application__c(
                Name = name,
                Email__c = email,
                Preferred_Phone__c = phone,
                Referred_By__c = referredBy,
                Cover_Letter__c = coverLetter
            );

            insert jobRecord;
            return jobRecord.Id;

        } catch(Exception e) {
          
            throw new AuraHandledException('Error creating job record: ' + e.getMessage());
        }
    }


}