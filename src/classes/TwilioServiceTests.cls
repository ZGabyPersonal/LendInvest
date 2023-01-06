@IsTest
public class TwilioServiceTests {
	@IsTest
    private static void testAccountTurnedGold() {
        Test.setMock(HttpCalloutMock.class, new TwilioResponseMock());
        
        Test.startTest();
        Boolean response = TwilioService.sendSMS('Test', '07938606860');
        Test.stopTest();
        
        System.assertEquals(true, response);
    }
}