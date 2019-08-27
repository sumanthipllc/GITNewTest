public class Hello {
    public enum Season {WINTER, SPRING, SUMMER, FALL}
     public Season s=Season.SUMMER;
  
        public void x()
        {    if(s == Season.SUMMER){ 

    // Will write the string value SUMMER
    System.debug(s);}

    else {
    System.debug('Not summer.');
}

    }
}