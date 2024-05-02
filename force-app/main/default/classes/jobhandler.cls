public class jobhandler {
    
    public static void main(){
        list<Job_Application__c> lst = [select id, Name from Job_Application__c];
    delete lst;
    }
    

}