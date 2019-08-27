public interface IAccountsSelector extends fflib_ISObjectSelector 
{
	List<Account> selectById(Set<ID> idSet);
	//List<Account> selectByOpportunity(List<Opportunity> opportunities);
}