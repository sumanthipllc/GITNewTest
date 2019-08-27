global class marksupdate implements database.batchable<Sobject>
{
    global database.querylocator start(database.batchablecontext bc)
    {
        system.debug('hello'+('select id,name,Number_Of_Subjects__c,Total_Aggregate__c,(select id,name,marks__c,subject__c from Student_s_Subject_Marks__r) from Student_Information__c'));
        return database.getquerylocator('select id,name,Number_Of_Subjects__c,Total_Aggregate__c,(select id,name,marks__c,subject__c from Student_s_Subject_Marks__r) from Student_Information__c');
    
    }
    
    global void execute(database.batchablecontext bc, list<Sobject> s )
    {
        Decimal aggregate;
        decimal total;
         map<string,Grades_Object__c> gradesmap = Grades_Object__c.getall();
         
         list<decimal> percentages = new list<decimal>();
         list<decimal> reversepercentages = new list<decimal>();
         
         map<decimal,string> percentagegrademap  = new map<decimal,string>();
         
         
         
                    for(string s2 : gradesmap.keyset())
                    {
                    
                            percentages.add(gradesmap.get(s2).percentage__C);
                            
                          percentagegrademap.put(gradesmap.get(s2).percentage__c,gradesmap.get(s2).Name);
                    }
         
         if(!percentages.isEmpty())
         {
             percentages.sort();
         }
         
         for(Integer i = percentages.size()-1;i>=0;i--)
         {
             reversepercentages.add(percentages.get(i));
         
         }
         
        
        list<Student_Information__c> tobeupdated= new list<Student_Information__c>();
        for(Sobject so:s){
        
        Student_Information__c stinf = (Student_Information__c)so;
        system.debug('hello'+stinf);
        
                   list<Student_Subject_Mark__c> markslist=stinf.Student_s_Subject_Marks__r;
                    total=0;
       if(markslist!=null && markslist.size()==6  )
        {
            for(Student_Subject_Mark__c ssm:markslist)   
            {
                total+=ssm.Marks__c;
                        system.debug('hello12'+total);

            } 
            stinf.Number_Of_Subjects__c=6;
            stinf.Total_Aggregate__c=(total/6);
            stinf.Student_Last_Name__c='last name';
                    system.debug('hello13'+(total/6));
                    
                  if(stinf.Total_Aggregate__c!= null)
                  {
                      for(decimal s1 : reversepercentages)
                      {
                          if(stinf.Total_Aggregate__c>=s1)
                          {
                              stinf.grade__c=percentagegrademap.get(s1);
                              break;
                          }
                      
                      }
                  
                  }
                    

            tobeupdated.add(stinf);
        }
        
        }
        
        system.debug('hello14'+tobeupdated);
        update tobeupdated;
    }
global void finish(database.batchablecontext bc)
{}

}