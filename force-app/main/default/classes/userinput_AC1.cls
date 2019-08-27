public class userinput_AC1 {

//public user username {get;set;}
//public user usr {get;set;}

public boolean istrue {get;set;}
public list<user> uid {get;set;}
//public user uname {get;set;}
//public  string namefrompage {get;set;}
public string sname {get;set;}
public list<Account> acc {get;set;}
public list<Contact> con {get;set;}
public string s {get;set;}
public id accountid {get;set;}
public list<MyWrapperClass> wrapperlist {get;set;}
public string relatedcontacts {get;set;}
public userinput_AC1()
{
    acc= new list<Account>();
    istrue=false;
   // username = new user();

}


public void selectaccs()
{    

    istrue=true;
    getaccconlist();
    



  /*  s='%' +sname+ '%'; 
    uid=[select ID,Name,Email from User where Name =:s];
    if(uid.size()>0){
    system.debug('@@@@@@@'+uid[0].id);
        //string searchquery='select id,name,createdbyID,createdbyID.email from Account where  createdbyId.email =: sname';
  // acc=database.query(searchquery);}
  
  acc=new list<Account>();
  con= new list<contact>();
  
  try{
  acc=[select id,name,Owner.email from Account Where Owner.email=:sname];
  con=[select id,name,Owner.email from Contact Where Owner.email=:sname];
  }
  
  catch(Exception e)
  {}*/
    
}


public list<MyWrapperClass> getaccconlist()
{

        
    
    acc=new list<Account>();
  con= new list<contact>();
  wrapperlist= new list<MyWrapperClass>();
  
  
  
 /* try{
  acc=[select id,name,Owner.email from Account Where Owner.email=:sname limit 5];
  con=[select id,name,Owner.email from Contact Where Owner.email=:sname];
  }*/
  
  try{
  acc=[select id,name,(select id,name from contacts) from account where owner.email=:sname];
  }
  
  catch(Exception e)
  {}
    /*Integer x;
    
    if(acc.size()>=con.size())
    {
        x=acc.size();
    }
    
    else {
        x=con.size();
    }*/



for(Account a: acc)
{
    relatedcontacts='';
    for(Contact c: a.contacts)
    {
        relatedcontacts= relatedcontacts+', '+c.name;
    
    }
            wrapperlist.add(new MyWrapperClass(a.id,a.name,relatedcontacts));

}

    
     
    return wrapperlist;
    
}


public class MyWrapperClass
{
    public id aid {get;set;}
    public string aname {get;set;}
   // public id cid {get;set;}
    public string relatedcontacts {get;set;}
    
    public MyWrapperClass(id naid,String naname,String ncname)
    {
        aid=naid;
        aname=naname;
        relatedcontacts=ncname;
    
    
    }

/*
string x 
for(account acc: list)
{
    for(contact con: acc.contact)
    {
        
    
    }

}*/



}


public pagereference detailpage()
{
     pagereference pg = new pagereference('/a00/o');
     pg.setredirect(true);
     return pg;

}

public pagereference detailpage1()
{
     pagereference pg = new pagereference('/'+Accountid);
     pg.setredirect(true);
     return pg;

}


/*
public user getusername()
{   namefrompage=ApexPages.currentPage().getParameters().get('username');
  uname=[select id,name,firstname,lastname from user where name=:namefrompage] ;
    return uname;
}


public string getuser()
{    usr= [select Id,Firstname,LastName from user limit 1];
     return usr.id;
}
*/







}