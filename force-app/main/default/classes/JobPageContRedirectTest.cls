@isTest
private class JobPageContRedirectTest {

    @isTest
    static void testRedirectMethod() {
        // Create test data for Job__c object
        Job__c testJob = new Job__c();
            testJob.Name = 'Test Job';
            // Set other required fields
    
        insert testJob;

        // Set the current page parameters
        ApexPages.currentPage().getParameters().put('id', testJob.Id);

        // Create an instance of JobPageContRedirect
        JobPageContRedirect controller = new JobPageContRedirect();

        // Call the redirectMethod and assert the PageReference
        PageReference resultPageRef = controller.redirectMethod();
        System.assertEquals(
            null + '/ApplyPage?id=' + testJob.Id,
            resultPageRef.getUrl(),
            'Unexpected URL for PageReference'
        );
    }

    @isTest
    static void testReturnsMethod() {
        // Create an instance of JobPageContRedirect
        JobPageContRedirect controller = new JobPageContRedirect();

        // Call the returns method and assert the URL
        String resultUrl = controller.returns();
        System.assertEquals(
            null + '/Jobslist?',
            resultUrl,
            'Unexpected URL returned by returns method'
        );
    }
}