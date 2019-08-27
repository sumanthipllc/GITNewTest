trigger accountsandrelatedcontactsupdate on Account (After Update) {


list<Contact> contactstobeupdated= new list<Contact>();
map<id,list<Contact>> idcontactslistmap= new map<id,list<Contact>>();

list<id> accountids = new list<id>();

for(Account acc:trigger.new)
{
    accountids.add(acc.id);
}

List<Contact> generalcontacts= new list<Contact>();
generalcontacts= [Select Id,Name,phone,accountid from Contact Where accountId IN:accountids];

list<Contact> updatecontacts = new list<Contact>();


for(Account acc:trigger.new)
{
    List<Contact> finalcontacts= new list<Contact>();
    
    for(Contact c:generalcontacts)
    {
    
        if(c.accountid==acc.id)
        {
            c.phone=acc.phone;
            updatecontacts.add(c);
        }
    
    }
    
   // idcontactslistmap.put(acc.id,finalcontacts);
}

/*for(Account acc:trigger.new)
{

    list<Contact> finaltoupdate = new list<Contact>();
    finaltoupdate=idcontactslistmap.get(acc.id);
    for(Contact con:finaltoupdate)
    {
        con.phone=acc.phone;
        contactstobeupdated.add(con);
    
    }
    
    


}


if(contactstobeupdated.size()>0)
{
    update contactstobeupdated;

}*/

if(updatecontacts.size()>0)
{
    update updatecontacts;
}


}