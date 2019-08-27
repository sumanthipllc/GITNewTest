Trigger triggerparentacc on Account (before Insert,after delete,after update)
{
    list<Account> acclist= new list<Account>();
    List<Account> updatedparentaccs = new list<Account>();
    set<string> accid= new set<string>();
    if(trigger.isBefore && trigger.isInsert){
      for(Account acc1:trigger.new)
        {
       if(acc1.parentid!=null)
            {    
                accid.add(acc1.parentid);
            }
   }
      if(!accid.isEmpty())
        {
         acclist=[select id,name,Is_a_Parent__c from Account where id IN:accid ];
            for(Account A: acclist)
            {
                a.Is_a_Parent__c=true;
                updatedparentaccs.add(a);
            }
        }
        
        /* for(Account acc:trigger.new)
{
if(acc.parentid!=null)
{
acclist=[select id,name,Is_a_Parent__c from Account where id IN:accid ];
acclist.Is_a_Parent__c=true;
updatedparentaccs.add(acclist);
}
}*/
        if(!updatedparentaccs.isEmpty())
            update updatedparentaccs;
    }
    list<Account> deletedaccstobeupdated;
    //map<string,list<account>> parentchild = new map<string,list<account>>();
    /* another way to make the parent account false for no child accounts
if(trigger.isAfter && trigger.isDelete)
{
for(Account acc:trigger.new)
{
if(acc.parentid!=null)
{
accid.add(acc.parentid);
}
} 
if(!accid.isEmpty())
{
// getting child accounts from heirarichy.
acclist=[select id,name,(select id,name from ChildAccounts) from Account where Id IN:accid ];
}
for(Account acc:acclist)
{
if(acc.ChildAccounts==null || acc.ChildAccounts.isEmpty())
{
acc.Is_a_Parent__c=false;
deletedaccstobeupdated.add(acc);
}
}
update deletedaccstobeupdated;
}
*/ 
    if(trigger.isAfter && trigger.isDelete)
    {
        List<Account> childacc;
        List<Account> parentacc;
        map<string,list<Account>> parentchildmap = new map<string,list<Account>>();
        for(Account acc:trigger.old)
        {
            if(acc.parentid!=null)
            {
                accid.add(acc.parentid);
            }
        }
        if(!accid.isEmpty())
        {
            childacc = [Select id,name,parentid from Account where parentid IN :accid];
            parentacc = [Select id,name,Is_a_Parent__c from account where id IN:accid];
        }
        for(Account acc:childacc)
        {
            if(parentchildmap.containskey(acc.parentid))
            {
                parentchildmap.get(acc.parentid).add(acc);
            }
            else {
                list<Account> childlist = new list<Account>();
                childlist.add(acc);
                parentchildmap.put(acc.parentid,childlist);
            }
        }
        list<account> updateaccs= new list<Account>();
        for(Account ac1:parentacc)
        {
            if(!parentchildmap.containskey(ac1.id) || parentchildmap.get(ac1.id).size()<=0)
            {
                ac1.Is_a_Parent__c=false;
                updateaccs.add(ac1);
            }
        }
        if(!updateaccs.isEmpty())
        {
            update updateaccs;}
    }
    if(trigger.isAfter && trigger.isUpdate)
    {
        set<string> oldids = new set<string>();
        set<string> newids = new set<string>();
        set<string> accountlistnew = new set<string>();
        set<string> accountlistold = new set<string>();
        list<Account> oldaccs = new list<Account>();
        list<Account> newaccs = new list<Account>();
        list<Account> upaccs = new list<Account>();
        for(Account a :trigger.new)
        {
            Account aold= trigger.oldmap.get(a.id);
            if(a.parentId!=aold.parentId)
            {
                //a.Is_a_Parent__c=true; 
                //ax1.Is_a_Parent__c=false; 
                accountlistold.add(aold.parentid);
                if(a.parentid!=null){
                    accountlistnew.add(a.parentid);}
            }
        }
        if(!accountlistnew.isEmpty())
        {
            newaccs=[Select id,name,parentid,Is_a_Parent__c from Account where id IN :accountlistnew]; 
        }
        if(!accountlistold.isEmpty())
        {
            oldaccs=[Select id,name,(Select id,name from ChildAccounts)parentid,Is_a_Parent__c from Account where id IN :accountlistold]; 
        }
        for(Account a1:newaccs)
        {
            a1.Is_a_Parent__c=true;
            upaccs.add(a1);
        }
        for(Account a2:oldaccs)
        {
            if(a2.childaccounts==null || a2.childaccounts.isEmpty()){
                a2.Is_a_Parent__c=false;
                upaccs.add(a2);}
        }
        if(!upaccs.isEmpty())
        {
            update upaccs;
        }
        /*
if(!newids.isEmpty())
{

acclist=[select id,name,Is_a_Parent__c from Account where id IN:newids ];
}

if(!oldids.isEmpty())
{

accountlist=[select id,name,Is_a_Parent__c from Account where id IN:oldids ];
}

for(Account A: acclist)
{


for(Account a1: accountlist)
{

if(a.parentId==a1.parentId)
{
a1.Is_a_Parent__c=true; 
updatedparentaccs.add(a1);

}

else
{
a1.Is_a_Parent__c=true; 
updatedparentaccs.add(a1);  

}

}
a.Is_a_Parent__c=true;
updatedparentaccs.add(a);

}

*/
    }
}
/* get all child accs using the set we created "where parent id in:accid".

create a map of parent id and all the child accs using the query, 

add the related accs with the same parent id into the map. 

then get the list from the map using the parent id set we have. and check for the condition if the size of list>0 then is parent is true or false. */