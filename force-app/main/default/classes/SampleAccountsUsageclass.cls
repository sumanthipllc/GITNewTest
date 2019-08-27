public class SampleAccountsUsageclass {
    
    public static void getAccounts(Set<ID> accIds)
    {
        List<Account> accRecords = 
            AccountSelector.newInstance().selectById(accIds);
        system.debug('Account records--'+accRecords);
    }
    
    public static void insertAccounts()
    {
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        for(Integer a=0; a<5; a++)
        {
            Account acc = new Account();
            acc.Name = 'UoW Test Name ' +a ;
            acc.Phone = '123456789'+a;
            uow.registerNew(acc);
        }
        uow.commitWork();
    }
    
    public static void insertAccountswithRelatedRecords()
    {
		fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        	Account account = new Account();
            account.Name = 'UoW Test Name';
            account.Phone = '123456789';
            uow.registerNew(account);
            for(Integer a=0; a<5; a++)
            {
                Contact contact1 = new Contact();
                contact1.FirstName = 'UoW first Name ' +a ;
                contact1.LastName = 'UoW last Name ' +a ;
                contact1.Phone = '123456789'+a;
                uow.registerNew(contact1, Contact.AccountId,account);
            }
            uow.commitWork();  
    }
    
    public static void updateRelatedContacts(Account newAcc, Account oldAcc,List<Contact> contactsList)
    {
        
        AccountsService.updateRelatedContacts(newAcc,oldAcc,contactsList);
        /*system.debug('maun method');
       // Account oldAcc = (Account)oldSo;
       // Account newAcc = (Account)newSo;
		fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        	
            for(Contact cnt : contactsList)
            {
               cnt.Description = 'Parent Account is Updated With Name from : '+oldAcc.Name+' to '+newAcc.name; 
               uow.registerDirty(cnt);
                system.debug('updated contacts--'+cnt.Description);
            }
            uow.commitWork();  */
    }
    
    public static void changeStatus(Set<ID> AccountsIds, string status)
    {
        AccountsService.changeStatus(AccountsIds,status);
    }
    
     public static void setDefaultsBeforeInsert(List<Account> sobjsList)
    {
        AccountsService.setStatus(sobjsList);
    }
}