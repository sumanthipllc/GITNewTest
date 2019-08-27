public class Convertpage_AC {


    public string convertedstatus {get;set;}
    public string Accname {get;set;}
    public string Oppname {get;set;}
    public string comments {get;set;}
    public string leadid {get;set;}
    public list<Account> acc {get;set;}
    public string leadname1 {get;set;}
   public string newoppname {get;set;}
  
    public list<Opportunity> opp {get;set;}
    public Convertpage_AC(ApexPages.StandardController controller) {
    leadid=ApexPages.currentPage().getParameters().get('id');
    
    leads__C l = [select id,name from leads__C where id=:leadid limit 1];
    
    oppname=l.name;
    leadname1=l.name;
    
    
    }



    public pagereference convert()
    {
    
     boolean opportunitynotcreated=false;
    system.debug('sumanth@'+newoppname+'@@'+oppname);
        acc=[select id,name from account where name=:leadname1];
       
    opp=[select id,name from opportunity where name=:oppname];
    
        account a= new account();


    if((acc.isempty()))
    {
                    system.debug('@@@@@oppl'+leadname1);

        system.debug('@@@@@acc'+acc.size());
        a.name=leadname1;
        insert a;
                   // apexPages.Message msg= new apexPages.Message(apexPages.Severity.info,'Account created');
                     //    apexPages.addMessage(msg);
    }
    
    if((opp.isempty()))
    {
                    opportunity o= new opportunity();

                system.debug('@@@@@opp'+opp.size());

        o.name=oppname;
        o.closedate=system.today();
        o.stagename='prospecting';
        insert o;
       // apexPages.Message msg= new apexPages.Message(apexPages.Severity.info,'Opp created');
         //                apexPages.addMessage(msg);
    }
    
     if(!(opp.isempty()))
    {
        opportunitynotcreated=true;
    
        apexPages.Message msg= new apexPages.Message(apexPages.Severity.Error,'this Opp already exists, duplicate Opp');
        apexPages.addMessage(msg);
    }
    
    
    if(!(acc.isempty())){
            apexPages.Message msg= new apexPages.Message(apexPages.Severity.Error,'this account already exists, duplicate account');
            
            apexPages.addMessage(msg);
            
    }
    
    
    
    pagereference page= null;
        if(a.Id!=null && !opportunitynotcreated)
        {
        page =  new pagereference('/'+a.id);
        
                page.setredirect(true);}
                
                return page;

        
    }
    
    public pagereference cancel()
    {
        system.debug('@@@@'+leadid);
        pagereference p = new pagereference('/'+leadid);
        p.setredirect(true);
        
        return p;
    }
}