public class ContactsSelector extends fflib_SObjectSelector
	implements IContactsSelector
{
	public static IContactsSelector newInstance()
	{
		return (IContactsSelector) Application.Selector.newInstance(Contact.SObjectType);
	}
	
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
            Contact.FirstName,
            Contact.LastName,
            Contact.ID,
            Contact.OwnerId,
            Contact.AccountId,    
            Contact.Description    
		};
	}
	
	public Schema.SObjectType getSObjectType()
	{
		return Contact.sObjectType;
	}

    public List<Contact> selectByParentAccount(Set<ID> idSet)
	{
      fflib_QueryFactory query = newQueryFactory();
      query.setCondition('AccountId IN :idSet');
      return (List<Contact>) Database.query(query.toSOQL());
	}
    
	public List<Contact> selectById(Set<ID> idSet)
	{
		return (List<Contact>) selectSObjectsById(idSet);
	}

}