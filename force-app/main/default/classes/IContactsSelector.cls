public interface IContactsSelector extends fflib_ISObjectSelector 
{
	List<Contact> selectById(Set<ID> idSet);
    List<Contact> selectByParentAccount(Set<ID> idSet);
	//List<Account> selectByOpportunity(List<Opportunity> opportunities);
}