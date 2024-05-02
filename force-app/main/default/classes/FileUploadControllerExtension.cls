public without sharing class FileUploadControllerExtension {

    public  String firstName { get; set; }
    public  String LastName { get; set; }
     public  String recordId { get; set; }
    public  Blob resume { get; set; }
    public  String resumeName { get; set; }
    public  String resumeText { get; set; }
    public  String Email { get; set; }
    public   String phone { get; set; }
    public  String referredby { get; set; }
    public  String Address { get; set; }
    public  Blob coverletter { get; set; }
    public  String coverlettername { get; set; }
    public  String coverletterText { get; set; }
    public string url {get;set;}
    public Boolean hasNameError { get; set; }
    public Boolean hasEmailError { get; set; }
    public Boolean hasPhoneError {get; set; }
    public boolean hasResumeError {get; set;}
    public App_setting_Ref__c var;
    
    
    
     public FileUploadControllerExtension() {
        // Fetch the Id parameter from the URL
        var =  App_Setting_Ref__c.getInstance();
        recordId = ApexPages.currentPage().getParameters().get('id');
         url= var.External_Community_Or_Site_URL__c+ '/JobsList?';
		hasNameError = false;
        hasEmailError = false;
        hasPhoneError = false;
        hasResumeError = false; 
         System.debug('Constructor executed. hasNameError: ' + hasNameError + ', hasEmailError: ' + hasEmailError + ', hasPhoneError: ' + hasPhoneError + ', hasResumeError: ' + hasResumeError);
    }
    
     public PageReference saveAndRedirect() {
         If(validateFields()) { 
        saveJobApplication();
			hasEmailError = false;
          hasNameError = false;  
             hasPhoneError = false;
             hasResumeError = false;
             
        // Redirect to the Thank You page
        PageReference thankYouPage = new PageReference(var.External_Community_Or_Site_URL__c + '/ThankYou?');
        thankYouPage.setRedirect(true);
        return thankYouPage;
         }
         return null;
   }
    
    	
    Public void saveJobApplication(){
        Job_Application__c jobApp = new Job_Application__c();
        jobApp.Name= firstName +' '+ LastName;
        System.debug('NAME=>' + jobApp.Name );
        jobApp.Email__c= Email;
        jobApp.Preferred_Phone__c= phone;
        jobApp.Referred_By__c= referredby;
        jobApp.Cover_Letter__c= coverletterText;
        jobApp.Address__c= Address;
        jobApp.Resume__c = resumeText;
        jobApp.Job__c= recordId;
        insert jobApp;
        System.debug('jobApp=>' + jobApp);
        
        if(resume != null){
            attachment resumeAttchment= new attachment();
            resumeAttchment.Name = resumeName;
            resumeAttchment.Body= resume;
            resumeAttchment.ParentId= jobApp.Id;
            insert resumeAttchment;
        }
        
       
        if(coverletter != null){
            attachment coverAttchment= new attachment();
            coverAttchment.Name = coverlettername;
            coverAttchment.Body= coverletter;
            coverAttchment.ParentId= jobApp.Id;
            insert coverAttchment;
        }
    }
    
     public Boolean validateFields() {
        Boolean isValid = true;

        if (String.isBlank(firstName)&& String.isBlank(lastName)) {
            hasNameError = true;
            isValid = false;
        } else {
            hasNameError = false;
        }

        if (String.isBlank(Email) || !isValidEmail(Email)) {
            hasEmailError = true;
            isValid = false;
        } else {
            hasEmailError = false;
        }

		 if (String.isBlank(phone)) {
             hasPhoneError = true;
            isValid = false;
        } else {
            hasPhoneError = false;
        }
        if (resume == null || resume.size() == 0) {
  		   hasResumeError = true;
            isValid = false;
        } else {
            hasResumeError = false;
        }
        return isValid;
    }
        private Boolean isValidEmail(String email) {
    // Regular expression for a simple email format validation
    String emailRegex = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';
    Pattern emailPattern = Pattern.compile(emailRegex);
    Matcher emailMatcher = emailPattern.matcher(email);
    return emailMatcher.matches();
}
    public String getUrl() {
    // Provide the URL to navigate to
      url= var.External_Community_Or_Site_URL__c+ '/Jobdetails?id='+recordId;
    return url;
}
   
}