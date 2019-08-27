@RestResource(urlMapping = '/Accountinfo/*')
global class restaccountrecords
{
 @httpGet
 global static list<Account>  method1()
 {
     
     RestRequest req = Restcontext.request;
     RestResponse res = Restcontext.response;
     String lang = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
     string name = null;
     list<Account> acc;
     
         acc = [select id,name from Account limit 100];
     
     return acc;
     
 
 } 
 
 @httpPost
 global static string method2()
 {
     RestRequest req = Restcontext.request;
     RestResponse res = Restcontext.response;
    
    try{
        //List<RestWrapperClass> wrapList = new list<RestWrapperClass>();
         List<Bank__C> bnkList = new list<Bank__C>();
         List<Account> accListToBeInserted  = new List<Account>();
         List<Customer__C> cusToBeInserted = new List<customer__C>();
         Set<String> AccName = new Set<String>();
         Map<String, id> AccNameIdMap = new Map<String,Id>();
         Set<String> cusName = new Set<String>();
         Map<String, id> cusNameIdMap = new Map<String,Id>();
        system.debug('sets--->'+accname+cusname);
     	
         RestWrapperClass rwc = new RestWrapperClass();
        // list<RestWrapperClass> rwcList = (list<RestWrapperClass>) JSON.deserialize(req.requestBody.toString(), list<RestWrapperClass>.class);
                  rwc = (RestWrapperClass) JSON.deserialize(req.requestBody.toString(), RestWrapperClass.class);

    // system.debug('test--->'+rwc.name+rwc.accountn+rwc.customern);
     
        
         for(integer i=0; i<= rwc.bankDetails.size(); i++)
         {
             if(rwc.bankDetails[i].Accountn != '' )
             {
             AccName.add(rwc.bankDetails[i].Accountn);
                 }
             
              if(rwc.bankDetails[i].customern != null)
             {
                 cusName.add(rwc.bankDetails[i].customern);
             }
             
             
         }
        
        List<Account> accList = [select id,name from Account where Name IN : AccName]; 
        List<Customer__C> custList = [select id,name from customer__C where Name IN : cusName];
        
          }
     catch(exception e)
        {
        system.debug('testtttt--->>'+e);
        }  
 
     return 'success';
 }
}
    /*    
     for(integer i=0; i<= rwc.bankDetails.size(); i++)
         {
             system.debug('rec name-->'+rwc.bankDetails[i].Accountn);
             if(rwc.bankDetails[i].Accountn != '' )
             {
                List<Account> accList = [select id,name from Account where Name =:rwc.bankDetails[i].Accountn limit 1]; 
                                                   system.debug('accounts-->'+acclist+accName);

                 if(accList.size() == 0)
                 {
                     Account acc = new Account();
                     acc.Name = rwc.BankDetails[i].Accountn;
                     accListToBeInserted.add(acc);
                     accName.add(rwc.BankDetails[i].Accountn);
                     
                 }
                 
                 else if(accList.size()>0)
                 {
                     accName.add(rwc.bankDetails[i].Accountn);
                 }
                                  system.debug('accounts-->'+acclist+accName);

             }
             system.debug('test1');
             if(rwc.bankDetails[i].customern != null)
             {
                 List<Customer__C> custList = [select id,name from customer__C where Name =:rwc.bankDetails[i].customern limit 1];
                 if(custList.size() == 0)
                 {
                     customer__C cus = new customer__C();
                     cus.Name = rwc.bankDetails[i].customern;
                     cusToBeInserted.add(cus);
                     cusName.add(rwc.bankDetails[i].customern);
                     
                 }
                 else
                 {
                     cusName.add(rwc.bankDetails[i].customern);
                 }
                 
             }
             
                          system.debug('test2'+accListToBeInserted.isEmpty()+'testsize1---->'+cusToBeInserted);

             system.debug('AccName1-->'+AccName+cusName);
              if(accListToBeInserted.size()>0)
         {
             upsert accListToBeInserted;
             system.debug('test3');
         }
         
         if(cusToBeInserted.size()>0)
         {
             upsert cusToBeInserted;
             system.debug('test4');
         }
         }
            
     if(!AccName.isEmpty())
     {
        // List<Account> fetchedAccount = [Select Id, Name From Account Where Name in:AccName ];
            for(Account ac : [Select Id, Name From Account Where Name in:AccName ]){
                AccNameIdMap.put(ac.Name, ac.Id);
            }
         system.debug('test5');
     }
         if(!cusName.isEmpty())
     {
        // List<Account> fetchedAccount = [Select Id, Name From Account Where Name in:AccName ];
            for(customer__C ac : [Select Id, Name From customer__C Where Name in:cusName ]){
                cusNameIdMap.put(ac.Name, ac.Id);
            }
         system.debug('test6');
     }
     
     for(Integer i = 0; i < rwc.bankDetails.size(); i++){          
            Bank__C bank = new bank__C();
            bank.Name = rwc.bankDetails[1].Name;
            
            bank.RelatedAccount__c = accNameIdMap.get(rwc.bankDetails[i].Accountn);
            bank.Relatedcustomer__c = cusNameIdMap.get(rwc.bankDetails[i].customern);
         	bnkList.add(bank);
        }
         system.debug('hello---->'+bnkList);
        if(bnkList.size()>0){
            insert bnkList;
        }
            
     }
     catch(exception e)
       {
      system.debug('testtttt--->>'+e);
        }   
 
     return 'success';
     
       /* 
        for(integer i=0; i<= rwc.size(); i++)
         {
             //system.debug('rec name-->'+rwc.bankDetails[i].Accountn);
             if(rwc[i].Accountn != '' )
             {
                List<Account> accList = [select id,name from Account where Name =:rwc[i].Accountn limit 1]; 
                                                   system.debug('accounts-->'+acclist+accName);

                 if(accList.size() == 0)
                 {
                     Account acc = new Account();
                     acc.Name = rwc[i].Accountn;
                     accListToBeInserted.add(acc);
                     accName.add(rwc[i].Accountn);
                     
                 }
                 
                 else if(accList.size()>0)
                 {
                     accName.add(rwc[i].Accountn);
                 }
                                  system.debug('accounts-->'+acclist+accName);

             }
             system.debug('test1');
             if(rwc[i].customern != null)
             {
                 List<Customer__C> custList = [select id,name from customer__C where Name =:rwc[i].customern limit 1];
                 if(custList.size() == 0)
                 {
                     customer__C cus = new customer__C();
                     cus.Name = rwc[i].customern;
                     cusToBeInserted.add(cus);
                     cusName.add(rwc[i].customern);
                     
                 }
                 else
                 {
                     cusName.add(rwc[i].customern);
                 }
                 
             }
             
                          system.debug('test2'+accListToBeInserted.isEmpty()+'testsize1---->'+cusToBeInserted);

             system.debug('AccName1-->'+AccName+cusName);
              if(accListToBeInserted.size()>0)
         {
             upsert accListToBeInserted;
             system.debug('test3');
         }
         
         if(cusToBeInserted.size()>0)
         {
             upsert cusToBeInserted;
             system.debug('test4');
         }
         }
            
     if(!AccName.isEmpty())
     {
        // List<Account> fetchedAccount = [Select Id, Name From Account Where Name in:AccName ];
            for(Account ac : [Select Id, Name From Account Where Name in:AccName ]){
                AccNameIdMap.put(ac.Name, ac.Id);
            }
         system.debug('test5');
     }
         if(!cusName.isEmpty())
     {
        // List<Account> fetchedAccount = [Select Id, Name From Account Where Name in:AccName ];
            for(customer__C ac : [Select Id, Name From customer__C Where Name in:cusName ]){
                cusNameIdMap.put(ac.Name, ac.Id);
            }
         system.debug('test6');
     }
     
     for(Integer i = 0; i < rwc.size(); i++){          
            Bank__C bank = new bank__C();
            bank.Name = rwc[i].Name;
            
            bank.RelatedAccount__c = accNameIdMap.get(rwc[i].Accountn);
            bank.Relatedcustomer__c = cusNameIdMap.get(rwc[i].customern);
         	bnkList.add(bank);
        }
         system.debug('hello---->'+bnkList);
        if(bnkList.size()>0){
            insert bnkList;
        
   
    
}*/