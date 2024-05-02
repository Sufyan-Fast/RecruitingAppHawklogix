@istest
private class FileUploadControllerExtensionTest {

    @isTest
    static void testSaveAndRedirect() {
        // Create a test App_setting_Ref__c record
        App_setting_Ref__c testSetting = new App_setting_Ref__c(
            External_Community_Or_Site_URL__c = 'https://hawklogixpakistan3-dev-ed.develop.my.site.com'
            // Add other required fields here
        );
        insert testSetting;

        // Create a test Job__c record
        Job__c testJob = new Job__c(
            Name = 'Test Job',
            Post_Externally__c	= true ,
            Posting_Status__c= 'Internal and External'
            // Add other required fields here
        );
        insert testJob;

        // Set up the current page with parameters
      	PageReference pageRef = Page.ApplyPage; // Replace with the actual name of your Visualforce page
       // Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', testJob.Id);
		
        // Create an instance of the controller and invoke the constructor
        FileUploadControllerExtension controller = new FileUploadControllerExtension();
        controller.var = testSetting;
        controller.recordId = testJob.Id;
        controller.firstName= 'test123tets';
        controller.lastName= 'tetets';
        controller.Address='abc Karachi';
        controller.coverletter=Blob.valueOf('test');
        controller.coverlettername='test';
        controller.Email='anass@gmail.com';
        controller.phone='012321931';
        controller.resumeName = 'Sample';
        controller.resume=Blob.valueOf('test2');
        controller.coverletterText='32231';
        
        

        // Set other properties as needed for testing

        // Invoke the saveAndRedirect method
        PageReference result = controller.saveAndRedirect();

        // Perform assertions to validate the behavior of the method
        System.assertNotEquals(null, result, 'PageReference should not be null');
        System.assertEquals(testSetting.External_Community_Or_Site_URL__c + '/ThankYou', result.getUrl(),
            'PageReference URL should match the expected URL');
    }

    

}