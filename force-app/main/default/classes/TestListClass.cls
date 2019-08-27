public class TestListClass {
	@AuraEnabled
    public List<Account> getAccounts()
    {
        return [SELECT id,name from Account];
        
    }
}