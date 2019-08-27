public class customController {
public string cString { get; set;}
public void getStringMethod1(){
test();
}
public string getStringMethod2(){
if(cString == null)
cString = 'Method2';
return cString;
}

public void test()
{
    system.debug('sumanth'+cString);
}

}