trigger accountscontact on Account (before insert,after insert) {

    list<Contact> licon=new list<Contact>();
    
    if(trigger.isBefore && trigger.isInsert)
    {
        for(Account acc:trigger.new)
        {
            if(acc.phone=='' || acc.phone==null)
            {
                acc.phone='1234567890';
                
            }
            
            acc.AccountNumber='sumanth.a8@gmail.com';
        
        }
    
    
    }
    
    
        if(trigger.isafter && trigger.isInsert)
        {

    for(Account acc:trigger.new)
    {
        contact con=new contact();
        con.LastName=acc.name;
        con.phone=acc.phone;
        //con.account=acc;
        con.AccountId=acc.id;
        con.department=acc.AccountNumber;
        licon.add(con);
    
    }
    
    try{
            insert licon;
    }
    
    catch(exception e)
    {}

    }
}