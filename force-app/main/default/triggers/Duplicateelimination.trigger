trigger Duplicateelimination on sumanth__C(before insert,before update)
    
  //  string ss = '%'+s.name+'%';
    //list<sumanth__C> sumanthrecords = [select id,name from sumanth__C where name like s];

{
public list<sumanth__C> sumanthrecords = new list<sumanth__C>();
 public set<string> testSet = new set<string>();
 public string ss;
    
        if((trigger.isbefore && trigger.isupdate) || (trigger.isbefore && trigger.isInsert))
        {
            
            for(sumanth__C s : trigger.new)
            {
                 ss = '%'+s.name+'%';
                testSet.add(ss);
                           
            }
            
           
            sumanthrecords = [select name from sumanth__C where name like : ss];
            
           if(sumanthrecords!=null && sumanthrecords.size()>0)
           
         /*  {
           for(sumanth__C s : trigger.new)
            {
                for(sumanth__C sum : sumanthrecords)
                {
                    if(s.name==sum.name)
                    {*/
                    trigger.new[0].adderror('duplicate');
                    /*}
                }
            }}*/
            
        }
    
}