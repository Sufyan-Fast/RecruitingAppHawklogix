public without sharing class lwc_Form_Controller {

    @AuraEnabled
    public static void saveJobApplication(
        String applicantName,
        String Email, 
        String phone, 
        String Addresses,
        String referredby,
        String resumeDocumentId,
        String coverDocumentId
    ){
        Job_Application__c jobApp = new Job_Application__c();
        
        jobApp.Name = applicantName;
        jobApp.Job__c = 'a025j00000mBOKCAA4';
        jobApp.Email__c = Email;
        jobApp.Preferred_Phone__c = phone;
        jobApp.Address__c = Addresses;
        jobApp.Referred_By__c = referredby; 
           
        insert jobApp;
        
        if (String.isNotBlank(resumeDocumentId)) {
            // Attach the uploaded file to the newly created record
            ContentDocumentLink contentLink = new ContentDocumentLink();
            contentLink.LinkedEntityId = jobApp.Id;
            contentLink.ContentDocumentId = resumeDocumentId;
            contentLink.ShareType = 'V';
            contentLink.Visibility = 'AllUsers';
            insert contentLink;
        }
        
        if (String.isNotBlank(resumeDocumentId)) {
            // Attach the uploaded file to the newly created record
            ContentDocumentLink CoverLink = new ContentDocumentLink();
            CoverLink.LinkedEntityId = jobApp.Id;
            CoverLink.ContentDocumentId = coverDocumentId;
            CoverLink.ShareType = 'V';
            CoverLink.Visibility = 'AllUsers'; 
            insert CoverLink;
        }
    }
}