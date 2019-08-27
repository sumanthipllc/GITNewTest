trigger OwnershipTrigger on Account (before insert) {
    List<Account> acc = new List<Account>();
   // List<Account> parentAcc = new List<Account>();
    Map<Id,Account> parentAccMap = new Map<Id,Account>();
    Set<Id> accIds = new Set<Id>();
    for(Account a : Trigger.new)
    {
            //a.OwnerId='0050a00000J8bzL';
        if(a.parentId!=null)
        {
            accIds.add(a.parentId);
        }
        
    }
    if(accIds.size()>0)
    {
        for(Account a:[SELECT id,name,ownerId from Account where id IN :accIds])
        {
            parentAccMap.put(a.id,a);
        }
    }
    for(Account a : Trigger.new)
    {
            if(parentAccMap.containsKey(a.ParentId) && (a.OwnerId!=parentAccMap.get(a.parentId).OwnerId))
               {
                   a.OwnerId = parentAccMap.get(a.parentId).OwnerId;
                   
               }
        
    }
    
}