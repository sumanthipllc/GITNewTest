public class schedulebatch implements schedulable{

    public void execute(schedulablecontext sc)
    {
    
        database.executebatch(new AccountsParentBatch());
    }
}