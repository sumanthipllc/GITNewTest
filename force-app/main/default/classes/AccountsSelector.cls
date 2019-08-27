public class AccountsSelector extends fflib_SObjectSelector {

//this gives the fields to be returned from the soql.
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.ID,
            Account.Description,
            Account.Name,
            Account.AnnualRevenue };
    }
//this gives the sObject on which we want to run the SOQL. 
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
//this is the actual method where the sowl is executed or initialized executing the above methods, the soql runs bu the ids passed.
    public List<Account> selectById(Set<ID> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }
}