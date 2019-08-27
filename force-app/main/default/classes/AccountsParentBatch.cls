Global class AccountsParentBatch implements Database.Batchable<Sobject>{


    global Database.QueryLocator start(Database.Batchablecontext bc)
    {
        return Database.getQueryLocator('select id,name,parentid,Is_a_Parent__c,(select id,name,Is_a_Parent__c from childaccounts) from Account');
    }

    global void execute(Database.BatchableContext bc,list<Sobject> c)
    {
                system.debug('@@@@--');

        list<Account> acclist = new list<Account>();
        
       for(Sobject so:c){
               Account acc=(Account)so;
               list<Account> childlist = acc.childaccounts;
               if(childlist!=null && childlist.size()>0 && acc.Is_a_Parent__c!=true)
               {
                   acc.Is_a_Parent__c=true;
                   acclist.add(acc);
               }
               
               else if((childlist==null || childlist.size()<=0) && acc.Is_a_Parent__c!=false){
               
                   acc.Is_a_Parent__c=false;
                   acclist.add(acc);
               }
               
        }
        
        system.debug('@@@@--'+acclist);
        database.update(acclist,false);
    }
    
    global void finish(Database.BatchableContext bc)
    {
    
    }


}