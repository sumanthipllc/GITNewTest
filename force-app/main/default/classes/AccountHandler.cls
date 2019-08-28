/* Class AccountHandler: Trigger Handler for the Account SObject. This class implements the ITrigger
* interface to help ensure the trigger code is bulkified and all in one place.
  Gut changes test by sumanth.
*/
public with sharing class AccountHandler
implements ITrigger
{	
    private Set<Id> m_inUseIds = new Set<Id>();
    private List<Contact> relatedRecordsList = new List<Contact>();
    private Map<ID,List<Contact>> AccountAndRelatedContactsMap = new Map<ID,List<Contact>>();
    // Constructor
    public AccountHandler()
    {
    }
    
    /* bulkBefore : This method is called prior to execution of a BEFORE trigger. Use this to cache any data required into maps prior execution of the trigger.
	*/
    public void bulkBefore()
    {
        // test This is the method which fetches the related records and all the ones to be processed in the trigger.
    }
    
    public void bulkAfter()
    {
        if (Trigger.isUpdate)
        { 
            m_inUseIds = Trigger.oldMap.keySet();
            relatedRecordsList = ContactsSelector.newInstance().selectByParentAccount(m_inUseIds); 
            system.debug('contacts list--'+relatedRecordsList);
            for(Contact cnt : relatedRecordsList)
            {
                if(AccountAndRelatedContactsMap.containsKey(cnt.AccountId))
                    AccountAndRelatedContactsMap.get(cnt.AccountId).add(cnt);
                else
                    AccountAndRelatedContactsMap.put(cnt.AccountId, new List<Contact>{cnt});
            }
        }
    }
    
    public void beforeInsert(SObject so)
    {
        List<Account> slist = new List<Account>();
        slist.add((Account)so);
        SampleAccountsUsageclass.setDefaultsBeforeInsert(slist);
    }
    
    public void beforeUpdate(SObject oldSo, SObject so)
    {        
    }
    
    /* beforeDelete : This method is called iteratively for each record to be deleted during a BEFORE trigger.
	*/
    public void beforeDelete(SObject so)
    {	
    }
    
    public void afterInsert(SObject so)
    {
    }
    
    public void afterUpdate(SObject oldSo, SObject so)
    {
        Account myNewAccount = (Account)so;
        Account myOldAccount = (Account)oldSo;
        system.debug('change'+myNewAccount.Name+'--'+myOldAccount.Name);
        if(myNewAccount.Name != myOldAccount.Name)
            SampleAccountsUsageclass.updateRelatedContacts(myNewAccount,myOldAccount,AccountAndRelatedContactsMap.get(myOldAccount.Id));
    }
    
    public void afterDelete(SObject so)
    {
    }
    
    /* andFinally : This method is called once all records have been processed by the trigger. Use this 
	   method to accomplish any final operations such as creation or updates of other records.
	*/
    public void andFinally()
    {
        // Handle any exception logging or perorm any post trigger logics.
    }
}