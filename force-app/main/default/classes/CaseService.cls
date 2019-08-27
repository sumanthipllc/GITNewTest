public with sharing class CaseService {

    public static void closeCases(Set<Id> caseIds, String closingReason) {
        if (caseIds == null || caseIds.size() == 0) {
            throw new CaseServiceException('Mention the cases which needs to be closed.');
        }
        
        if (closingReason == null || closingReason == '') {
            throw new CaseServiceException('Cannot close a case without the reason.');
        }
        
        List<Case> cases = [SELECT Id, Status, Reason FROM Case Where Id IN :caseIds];
        List<Case> closedCases = new List<Case>();
        
        for(Case caseToClose : cases) {
            caseToClose.Status = 'Closed';
            caseToClose.Reason = closingReason;
            
            closedCases.add(caseToClose);
        }
        
        SavePoint sp = Database.setSavepoint();
        if (closedCases.size() > 0) {
            try {
                update closedCases;
            } catch (Exception e) {
                Database.rollback(sp);
                throw e;
            }
        }
    }
    
    public class CaseServiceException extends Exception {}
}