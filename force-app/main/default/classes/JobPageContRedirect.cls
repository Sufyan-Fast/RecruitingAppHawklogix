public class JobPageContRedirect {
   public String recordId { get; set; }
    public String url { get; set; }
    public String url1 { get; set; }
    public App_setting_Ref__c var { get; set; }
    public Job__c jobs { get; set; }
    Public string experience { get; set; }
    Public string jobNumber { get; set; }
    Public DATE targetHireDate { get; set; }
    Public date datePosted { get; set; }
    Public string employmentType { get; set; }
    Public string jobRequirement { get; set; }
    Public string jobQualification { get; set; }
    Public string jobDescription { get; set; }
    Public string name { get; set; }
    Public string location { get; set; }
    Public string salary { get; set; }
    
    

    public JobPageContRedirect() {
        var = App_Setting_Ref__c.getInstance();
        url = var.External_Community_Or_Site_URL__c + '/JobsList?';
        recordId = ApexPages.currentPage().getParameters().get('id');
        if (recordId != null) {
            List<Job__c> jobList = [SELECT Id, Job_Number__c,Target_Hire_Date__c, Name, Experience_Required__c,Employment_type__c, date_posted__c, Job_Type__c, Country__c, City__c, Job_Requirements__c, Qualifications__c, Job_Description__c, salary__c FROM Job__c WHERE Id = :recordId LIMIT 1];
            system.debug(jobList);
            	
                jobs = jobList[0];
            	this.location= jobList[0].City__c + ', ' + jobList[0].Country__c;
            	this.salary= jobList[0].salary__c;
                this.experience = jobList[0].Experience_Required__c;
            	this.jobNumber = jobList[0].Job_Number__c;
            	this.targetHireDate = jobList[0].Target_Hire_Date__c;
           		this.datePosted = jobList[0].date_posted__c;
            	this.employmentType = jobList[0].Employment_type__c;
            	this.jobRequirement = jobList[0].Job_Requirements__c;
            	this.jobQualification = jobList[0].Qualifications__c;
            	this.jobDescription = jobList[0].Job_Description__c;
            	this.name = jobList[0].name;
                system.debug(experience);
        }
    }

    public PageReference redirectMethod() {
        try {
            System.debug('recordId => ' + recordId);
       
            System.debug('Redirect URL => ' + var.External_Community_Or_Site_URL__c + '/ApplyPage?id=' + recordId);
            PageReference pageRef = new PageReference(var.External_Community_Or_Site_URL__c + '/ApplyPage?id=' + recordId);
            return pageRef;
        } catch (Exception e) {
            System.debug('Exception in redirectMethod: ' + e.getMessage());
            return null; 
        }
    }

    public String returns() {
        App_setting_Ref__c var = App_Setting_Ref__c.getInstance();
        url1 = var.External_Community_Or_Site_URL__c + '/Jobslist?';
        return url1;
    }
    public String getUrl() {
    // Provide the URL to navigate to
      url= var.External_Community_Or_Site_URL__c+ '/JobsList?';
    return url;
    } 
}