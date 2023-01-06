public class TwilioService {
    public static final Twilio_Setting__mdt TWILIO_SETTING = Twilio_Setting__mdt.getInstance('Default');
    public static final Api_Setting__mdt API_SETTING = Api_Setting__mdt.getInstance('Twilio');
    
    
    public static void sendSMS(List<Account> accounts) {
        String directorNumber = TWILIO_SETTING.Director_Phone_Number__c;
        for(Account acc : accounts) {
            try {
                String message = TWILIO_SETTING.Gold_SMS_Message__c.replace('{companyName}', acc.Name);
            	makeSendSMSApiCall(message, directorNumber);
            } catch (Exception e) {
                //	log the api error
            }
            
        }
    }
    
    @AuraEnabled
    public static Boolean sendSMS(String message, String toNumber) {
        try {
            makeSendSMSApiCall(message, toNumber);
            return true;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    public static void makeSendSMSApiCall(String message, String toNumber) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        Map<String, String> requestData = new Map<String, String> {
            'Body' => message,
                'From' => TWILIO_SETTING.From_Phone_Number__c,
                'To' => toNumber
                };
                    String requestUrl = API_SETTING.API_Endpoint__c + '/2010-04-01/Accounts/' + API_SETTING.Account_Id__c + '/Messages.json';
        
        request.setMethod('POST');
        request.setEndpoint(requestUrl);
        
        Blob headerValue = Blob.valueOf(API_SETTING.Account_Id__c + ':' + API_SETTING.Auth_Token__c);
        // Base 64 Encode the blob and prepend "Basic "
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        // Add the basic auth string to the Request Header
        request.setHeader('Authorization', authorizationHeader);
        request.setBody(urlEncode(requestData));
        
        HttpResponse response = http.send(request);
    }
    
    static String urlEncode(Map<String, String> vals) {
        String result = '';
        for(String thisKey : vals.keySet()) {
            result += EncodingUtil.urlEncode(thisKey, 'UTF-8') + '=' + EncodingUtil.urlEncode(vals.get(thisKey), 'UTF-8') + '&';
        }
        return result.removeEnd('&');    
    }
}