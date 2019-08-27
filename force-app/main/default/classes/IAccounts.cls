public interface IAccounts extends fflib_ISObjectDomain{
	void changeStatus(string status,fflib_ISObjectUnitOfWork uow);
    void setStatus();
}