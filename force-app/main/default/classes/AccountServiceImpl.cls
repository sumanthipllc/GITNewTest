public class AccountServiceImpl implements IAccountService {
			
    public static void changeStatus(Set<ID> AccountsIds, string status)
	{
		// Create unit of work to capture work and commit it under one transaction
	    fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
		// Query Accounts
		List<Account> accRecords = 
			AccountSelector.newInstance().selectById(AccountsIds);
		// Apply changes via Accounts domain class behaviour
		IAccounts accs = Accounts.newInstance(accRecords);				
		accs.changeStatus(status, uow);
		// Commit updates to Accounts		
		uow.commitWork();						
	}
    public static void setStatus(List<Account> sobjsList)
	{
		IAccounts accs = Accounts.newInstance(sobjsList);				
		accs.setStatus();				
	}
    
     public static void updateRelatedContacts(Account newAcc, Account oldAcc,List<Contact> contactsList)
    {
        system.debug('maun method');
       // Account oldAcc = (Account)oldSo;
       // Account newAcc = (Account)newSo;
		fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        	
            for(Contact cnt : contactsList)
            {
               cnt.Description = 'Parent Account is Updated With Name from : '+oldAcc.Name+' to '+newAcc.name; 
               uow.registerDirty(cnt);
                system.debug('updated contacts--'+cnt.Description);
            }
            uow.commitWork();  
    }
}