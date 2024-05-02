public class controllerTestComponent {
    public string search {get;set;}
    public list <Account> searchResults {get;set;}
    
    public void searchname(){
        searchResults = [SELECT Id, Name FROM Account WHERE Name LIKE : '%' + search + '%'];
    }
}