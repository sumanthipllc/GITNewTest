public  with sharing class CustomSearchApx {
	@AuraEnabled
    public static List<Account> getProducts()
    {
        	return [SELECT id, name, phone FROM Account ORDER BY name DESC LIMIT 10 ];
        
    }
    
    @AuraEnabled
    public static List<Account> getMatchingAccounts(String searchString)
    {
        system.debug(searchString);
       
        //return [SELECT id,name,phone FROM Account where Name LIKE :'%'+searchString+'%' ORDER BY name];
        List<Account> acc = new List<Account>();
        //Acc = [FIND:searchString IN ALL FIELDS RETURNING Account(Id,Name)];
        if(searchString!='' && searchString!=null && searchString!=' ')
            return [SELECT Id,Name,phone FROM Account WHERE Name LIKE :'%'+searchString+'%' OR Phone LIKE :'%'+searchString+'%'  ORDER BY Name ];
        else
            return null;
        
    }
}