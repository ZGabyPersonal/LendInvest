@IsTest
public class DataFactory {
    public static Account getAccount() {
        return new Account(Name = 'Test', Phone = '07938606860');
    }
    
    public static Opportunity getOpportunity(Id accountId) {
        return new Opportunity(Name = 'Test opp', AccountId = accountId, StageName = 'New', CloseDate = Date.today());
    }
}