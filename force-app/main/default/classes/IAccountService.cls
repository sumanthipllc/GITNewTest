public Interface IAccountService {
	void changeStatus(Set<ID> AccountIds, string status);
    void setStatus(List<Account> sobjsList);
    void updateRelatedContacts(Account newAcc, Account oldAcc,List<Contact> contactsList);
}