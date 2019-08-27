public class myController{

    public myController(ApexPages.StandardController controller) {

    }

public String myString{get;set;}
/*public StrIng getMyString() {
return 'getmyString'; 
}*/
public String getStringMethod1(){
 return myString; 
}
public String getStringMethod2(){
if (MyString ==null) 
Mystring='method2';
 return myString;
}
}