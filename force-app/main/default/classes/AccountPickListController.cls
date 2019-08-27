public class AccountPickListController {   
    @AuraEnabled public static String result {get;set;}
    @AuraEnabled
    public static List<String> getPickListValues(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.CustomerPriority__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        system.debug('test for vscode'+options);
        return options;
    }
    
    @AuraEnabled
    public static string createAccount(Account account)
    {
        
        Account parentAccount = new Account();
        parentAccount = account;
       // parentAccount.CustomexternalId__c='SAP1111110';   
        parentAccount.RecordTypeId = '0120a000001DkEk';
        insert parentAccount;
        
        Account chAcc = new Account();
        chAcc.name = account.name;
        chAcc.RecordTypeId ='0120a000001DkEp';
       
      //  Account accountReference = new Account(
        //    CustomexternalId__c='SAP1111110');    
         chAcc.Parent = parentAccount;
        insert chAcc;
        
        
        // Create the Account object to insert.
        // Same as above but has Name field.
        // Used for the insert.
        
        
        
        
        
        // Create the account and the opportunity.
       
     /*   Database.SaveResult[] results = Database.insert(new SObject[] {
            parentAccount, chAcc });
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
            System.debug('Successfully created ID: '
                  + results[i].getId());
                result +=results[i];
            } else {
            System.debug('Error: could not create sobject '
                  + 'for array element ' + i + '.');
            System.debug('   The error reported was: '
                  + results[i].getErrors()[0].getMessage() + '\n');
                result +=results[i].getErrors()[0].getMessage();
                
            }
        } */
       result =  parentAccount.Id+'-->'+chAcc.Id; 
        return result;
    }
}