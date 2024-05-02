@isTest
public class LWCSItesControllerTest {
	
   @isTest
    static void testGetJobData() {
        Job__c testJob = new Job__c(
            Name = 'Test Job',
            Target_Hire_Date__c = Date.today(),
            Job_Description__c = 'Sample job description',
            Date_Posted__c = Date.today(),
            Job_Requirements__c = 'Sample requirements',
            Qualifications__c = 'Sample qualifications',
            Job_Responsibilities__c = 'Sample responsibilities',
            Required_Skills__c = 'Sample skills',
            Experience_Required__c = '2 years'
        );
        insert testJob;

        try {
            Job__c result = LWCSItesController.getJobData(testJob.Id);

            System.assertEquals(testJob.Id, result.Id);
            System.assertEquals(testJob.Name, result.Name);
            System.assertEquals(testJob.Target_Hire_Date__c, result.Target_Hire_Date__c);
            System.assertEquals(testJob.Job_Description__c, result.Job_Description__c);
            System.assertEquals(testJob.Date_Posted__c, result.Date_Posted__c);
            System.assertEquals(testJob.Job_Requirements__c, result.Job_Requirements__c);
            System.assertEquals(testJob.Qualifications__c, result.Qualifications__c);
            System.assertEquals(testJob.Job_Responsibilities__c, result.Job_Responsibilities__c);
            System.assertEquals(testJob.Required_Skills__c, result.Required_Skills__c);
            System.assertEquals(testJob.Experience_Required__c, result.Experience_Required__c);
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception in try block: ' + e.getMessage());
        }
        
    }
    
     @isTest
    static void testGetAllJobs() {
        
         List<Job__c> testJobs = new List<Job__c>{
            new Job__c(
                Name = 'Job 1',
                Target_Hire_Date__c = Date.today(),
                Job_Description__c = 'Description 1',
                Date_Posted__c = Date.today(),
                Job_Requirements__c = 'Requirements 1',
                Qualifications__c = 'Qualifications 1',
                Job_Responsibilities__c = 'Responsibilities 1',
                Required_Skills__c = 'Skills 1',
                Experience_Required__c = '1 year'
            ),
            new Job__c(
                Name = 'Job 2',
                Target_Hire_Date__c = Date.today(),
                Job_Description__c = 'Description 2',
                Date_Posted__c = Date.today(),
                Job_Requirements__c = 'Requirements 2',
                Qualifications__c = 'Qualifications 2',
                Job_Responsibilities__c = 'Responsibilities 2',
                Required_Skills__c = 'Skills 2',
                Experience_Required__c = '2 years'
            )
        };
        
            insert testJobs;

        try {
            List<Job__c> result = LWCSItesController.getAllJobs();

            System.assertEquals(testJobs.size(), result.size());

            for (Integer i = 0; i < testJobs.size(); i++) {
                Job__c expectedJob = testJobs[i];
                Job__c actualJob = result[i];

                System.assertEquals(expectedJob.Id, actualJob.Id);
                System.assertEquals(expectedJob.Name, actualJob.Name);
                System.assertEquals(expectedJob.Target_Hire_Date__c, actualJob.Target_Hire_Date__c);
                System.assertEquals(expectedJob.Date_Posted__c, actualJob.Date_Posted__c);
                System.assertEquals(expectedJob.Job_Requirements__c, actualJob.Job_Requirements__c);
                System.assertEquals(expectedJob.Qualifications__c, actualJob.Qualifications__c);
                System.assertEquals(expectedJob.Job_Responsibilities__c, actualJob.Job_Responsibilities__c);
                System.assertEquals(expectedJob.Required_Skills__c, actualJob.Required_Skills__c);
                System.assertEquals(expectedJob.Experience_Required__c, actualJob.Experience_Required__c);
                System.assertEquals(expectedJob.Job_Description__c, actualJob.Job_Description__c);
                
            }
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception in try block: ' + e.getMessage());
        }
        
    }
    
    @isTest
    static void testGetViewAllJobs() {
        
        
        Job__c job1 = new Job__c(Name = 'Job 1');
        Job__c job2 = new Job__c(Name = 'Job 2');
        
        insert new List<Job__c>{job1, job2};
        
        
        List<Job__c> result = LWCSItesController.getViewAllJobs();
        
        System.assertNotEquals(null, result);
        
        System.assertEquals('Job 1', result[0].Name);
        
        System.assertEquals('Job 2', result[1].Name);
     
    }
    
     @isTest
    static void testSearchJobs() {
        
        Job__c testJob = new Job__c(Name = 'Test Job');
        insert testJob;

        
        List<Job__c> resultWithQuery = LWCSItesController.searchJobs('Test');
        System.assertEquals(1, resultWithQuery.size());

        
        List<Job__c> resultWithoutQuery = LWCSItesController.searchJobs('');
        System.assertEquals(1, resultWithoutQuery.size());
        
    }
    
    @isTest
    static void testSaveJobApplication() {
      
        Job__c testJob = new Job__c(Name = 'Test Job');
        insert testJob;

        
        LWCSItesController.saveJobApplication(
            'John Doe',
            testJob.Id,
            'john.doe@example.com',
            '1234567890',
            '123 Main St, City',
            'Referrer',
            'fileContents',
            'fileName.txt',
            'fileCoverContents',
            'coverLetter.txt'
        );

        
        Job_Application__c jobApp = [SELECT Id FROM Job_Application__c WHERE Job__c = :testJob.Id LIMIT 1];
        System.assertNotEquals(null, jobApp);

        
        List<ContentDocumentLink> contentDocumentLinks = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :jobApp.Id];
        System.assertEquals(2, contentDocumentLinks.size());
        
    }
    
    @isTest
    static void testSaveJobApplicationWithException() {
        try {
            
            LWCSItesController.saveJobApplication(
                'John Doe',
                'invalidJobId',  // Invalid Job ID to simulate an exception
                'john.doe@example.com',
                '1234567890',
                '123 Main St, City',
                'Referrer',
                'fileContents',
                'fileName.txt',
                'fileCoverContents',
                'coverLetter.txt'
            );

            System.assert(false, 'Expected exception not thrown');
        } catch (Exception e) {
            
            System.assert(e.getMessage().contains('Invalid id: invalidJobId'), 'Unexpected exception message');
        }
    }
    
     @isTest
    static void testGetLWCSitesURL() {      
        String result = LWCSItesController.getLWCSitesURL();
       // System.assertEquals('ExpectedURLValue', result, 'The URL should match the expected value');
    }


    
}