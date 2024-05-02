public class AccountListController {
    
    
    public List<Job__c> JobList { get; set; }
    public String searchKeyword { get; set; }
	
    public AccountListController() {
        searchKeyword = '';
       
        loadAllAccounts();
    }

    public void loadAllAccounts() {
        JobList = [SELECT Id, Name FROM Job__c];
    }
 
   
    public void searchAccounts() {
        JobList = [SELECT Id, Name FROM Job__c WHERE Name LIKE :'%'+searchKeyword+'%' ];
    }
       
}