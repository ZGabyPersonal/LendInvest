public class AccountTriggerHandler extends TriggerHandler {
    private static final String CUSTOMER_CLASSIFICATION_GOLD = 'GOLD';
    
	protected override void afterUpdate() {
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : (List<Account>) Trigger.new) {
            if(acc.Customer_Classification__c == CUSTOMER_CLASSIFICATION_GOLD && !acc.Customer_Reached_Gold_Status__c) {
                accountsToUpdate.add(acc);
            }
        }
        
        if(!accountsToUpdate.isEmpty()) {
            System.enqueueJob(new SendSmsQueueable(Trigger.new));
        }
    }
}