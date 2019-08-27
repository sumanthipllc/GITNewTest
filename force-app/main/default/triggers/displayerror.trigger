trigger displayerror on Contact (before Update) {
    
  /*  List<Contact> clist= new list<Contact>();
    
    for(Contact con: trigger.new)
    {
        clist.add(con.phone);
    }*/
    
    for(Contact con:trigger.new)
    {
    
        contact oldcon= trigger.oldMap.get(con.Id);
        if(oldcon.phone!=con.phone)
        {
            con.adderror('You cannot edit the phone number');
        }
    
    }

}