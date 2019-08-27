trigger studentsubjectvalidation on Student_Subject_Mark__c (before insert) {

    string subjectid,studentid;
    map<string,Student_Subject_Mark__c> studentsubjectmap = new map<string,Student_Subject_Mark__c>();
    List<Student_Subject_Mark__c> studentmarkslist = [Select id,name,student__c,subject__c from Student_Subject_Mark__c];
    map<string,list<string>> studentsubjectstcountmap = new map<string,list<string>>();
    for(Student_Subject_Mark__c sm1: studentmarkslist)
    {
        studentid=sm1.student__c;
        subjectid=sm1.subject__c;
        studentsubjectmap.put(studentid+subjectid,sm1);
        if(studentsubjectstcountmap.containskey(studentid))
        {
            studentsubjectstcountmap.get(studentid).add(subjectid);
        }
        else{
                list<string> subjectlist = new list<string>();
                subjectlist.add(subjectid);
                studentsubjectstcountmap.put(studentid,subjectlist);
        
        }

    }
    
    
    for(Student_Subject_Mark__c sm:trigger.new)
    {
        studentid=sm.student__c;
        subjectid=sm.subject__c;
       if(studentsubjectmap.containskey(studentid+subjectid))
       {
           sm.adderror('Records already exists with same subject for same student.');
       
       }
       
       else if(studentsubjectstcountmap.get(studentid)!=null && studentsubjectstcountmap.get(studentid).size()>=6 )
       {
           sm.adderror('Cannot insert record, a student can have maximum of 6 subjects');
       
       }
        
    }
    
    


}