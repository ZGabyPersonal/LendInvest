@IsTest
public class AccountTriggerHandlerTests {

    @IsTest
    private static void testAccountTurnedGold() {
        Test.setMock(HttpCalloutMock.class, new TwilioResponseMock());
        
        Account acc = DataFactory.getAccount();
        insert acc;
        
        Opportunity opp = DataFactory.getOpportunity(acc.Id);
        insert opp;
        
        Test.startTest();
        opp.Amount = 55000;
        opp.StageName = 'Closed Won';
        update opp;
        Test.stopTest();
        
        Account requeriedAccount = [SELECT Id, Customer_Reached_Gold_Status__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(true, requeriedAccount.Customer_Reached_Gold_Status__c);
    }
    
    @IsTest
    private static void testAccountTurnedGoldButAlreadyReachedGold() {
        Account acc = DataFactory.getAccount();
        acc.Customer_Reached_Gold_Status__c = true;
        insert acc;
        
        Opportunity opp = DataFactory.getOpportunity(acc.Id);
        insert opp;
        
        Test.startTest();
        opp.Amount = 55000;
        opp.StageName = 'Closed Won';
        update opp;
        Test.stopTest();
        
        Account requeriedAccount = [SELECT Id, Customer_Reached_Gold_Status__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(true, requeriedAccount.Customer_Reached_Gold_Status__c);
    }
    
    
}