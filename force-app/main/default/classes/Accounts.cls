public class Accounts extends fflib_SObjectDomain implements IAccounts {
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }

     public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Accounts(sObjectList);
        }
     }
     
    public void changeStatus(String status,fflib_ISObjectUnitOfWork uow)
    {
        for(Account acc: (List<Account>) Records)
        {
            // do some logic and change the status accordingly.
            if(acc.Description == null)
            {
            acc.Description = status;
            uow.registerDirty(acc);    
            }
        }
    }
     public override void onApplyDefaults()
    {
        // Apply defaults to account
        for(Account acc: (List<Account>) Records)
        {
            if(acc.Description == null)
            {
            acc.Description = 'Domain classes rock!';
            }
        }
    }
    
    public void setStatus()
    {
        // Apply defaults to account
        for(Account acc: (List<Account>) Records)
        {
            if(acc.Description == null)
            {
            acc.Description = 'Trigger defaults - Domain Class';
            }
        }
    }
    
    
    public override void handleBeforeInsert()
    {
        onApplyDefaults();
    }
    
    public static IAccounts newInstance(List<Account> sObjectList)
	{
		return (IAccounts) Application.Domain.newInstance(sObjectList);
	}
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        String rock = 'Domain classes rock!';
        List<Account> updatedAccounts = new List<Account>();
        for(Account acc : (List<Account>) Records) {                  
            acc.AnnualRevenue = rock.getLevenshteinDistance(acc.Description);
            updatedAccounts.add(acc);
        }
       
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        uow.registerDirty(updatedAccounts);
    }

    }