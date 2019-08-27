public class AccountSelector extends fflib_SObjectSelector
	implements IAccountsSelector
{
	public static IAccountsSelector newInstance()
	{
		return (IAccountsSelector) Application.Selector.newInstance(Account.SObjectType);
	}
	
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
            Account.Name,
            Account.ID,
            Account.OwnerId,
            Account.Description    
			/*Opportunity.AccountId,
			Opportunity.Amount,
			Opportunity.CloseDate,
			Opportunity.Description,
			Opportunity.ExpectedRevenue,
			Opportunity.Id,
			Opportunity.Name,
			Opportunity.Pricebook2Id,
			Opportunity.Probability,
			Opportunity.StageName,
			Opportunity.Type,
			Opportunity.DiscountType__c*/
		};
	}
	
	public Schema.SObjectType getSObjectType()
	{
		return Account.sObjectType;
	}

	public List<Account> selectById(Set<ID> idSet)
	{
		return (List<Account>) selectSObjectsById(idSet);
	}

}