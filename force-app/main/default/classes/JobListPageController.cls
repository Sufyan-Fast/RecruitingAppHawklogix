public class JobListPageController {
		public List<Job__c> jobs { get; set; }
    public string url {get; set;}
     public string url1 {get; set;}
    public Job__c selectedJob { get; set; }
     // Property for search query
    public string searchQuery { get; set; }

    // Property to store filtered jobs
    public List<Job__c> filteredJobs { get; set; }

    // Constructor to initialize the job list
    public JobListPageController() {
        selectedJob = new job__c();
        App_setting_Ref__c var= App_Setting_Ref__c.getInstance();
        url= var.External_Community_Or_Site_URL__c+ '/JobsList?';
jobs = [SELECT Id, Name, Job_Description__c, Employment_type__c, Job_Requirements__c, Job_Number__c, Date_Posted__c
FROM Job__c where Posting_Status__c = 'Internal and External' 
            AND Post_Externally__c = true
ORDER BY createddate DESC
LIMIT 6];        // Add more fields to the SELECT statement as needed
        url1 = var.External_Community_Or_Site_URL__c+ '/Jobdetails?';
         // Initialize filteredJobs with all jobs initially
        filteredJobs = jobs;      
        searchQuery = '';
    }
    
     public void searchJobs() {
        // If searchQuery is blank, display all jobs; otherwise, filter by job name
        system.debug('in search function');
        String searchrecord = '%' + searchQuery + '%';
        system.debug('searchrecord' + searchrecord );
        filteredJobs = (String.isBlank(searchQuery))
            ? jobs
            : [SELECT Id, Name, Job_Description__c, Employment_type__c, Job_Requirements__c, Job_Number__c, Date_Posted__c FROM Job__c
               WHERE Name LIKE :searchrecord AND Posting_Status__c = 'Internal and External' 
               AND Post_Externally__c = true ];
		system.debug(filteredJobs);
        // Debug statement to check the search query
        System.debug('Search Query: ' + searchQuery);
    }
    
    public void viewAllJobs() {
    // Perform a query to retrieve all jobs without any search criteria
    filteredjobs = [SELECT Id, Name, Date_Posted__c, Job_Description__c FROM Job__c 
                    where Posting_Status__c = 'Internal and External' 
            AND Post_Externally__c = true ORDER BY createddate DESC];
    searchQuery = ''; // Clear the search query
}
    
}