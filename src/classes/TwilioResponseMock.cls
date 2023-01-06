@IsTest
public class TwilioResponseMock implements HttpCalloutMock {
    private final String RESPONSE_BODY ='{"account_sid": "ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "api_version": "2010-04-01", "body": "This is the ship that made the Kessel Run in fourteen parsecs?"}';
    
    public HttpResponse respond(HttpRequest req){
        HttpResponse resp = new HttpResponse();
        resp.setBody(RESPONSE_BODY);
        resp.setStatusCode(200);
        return resp;
    }
}