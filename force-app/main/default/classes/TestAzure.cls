public class TestAzure {
    
      /* Test Method for Unit Testing Connection */

    public static String getMeetingUrl()

    {

        HttpRequest req = new HttpRequest();

        Http http = new Http();

        //Setup the Endpoint and append the name of the file

        req.setEndpoint('callout:MS_teams_Calender');

        req.setMethod('POST');

        req.setHeader('Content-Type','application/json');

        req.setHeader('Accept','*/*');

        req.setHeader('Accept-Encoding','gzip, deflate, br');

        //Setup the JSON Body – in the test just set a subject, can add more through Postman or other tests
        

        req.setBody('{' +
    '"subject": "Testing Integration SF with Teams",' +
    '"body": {' +
        '"contentType": "HTML",' +
        '"content": "Does this time work for you?"' +
    '},' +
    '"start": {' +
        '"dateTime": "2024-01-26T13:00:00",' +
        '"timeZone": "Asia/Karachi"' +
    '},' +
    '"end": {' +
        '"dateTime": "2024-01-26T14:00:00",' +
        '"timeZone": "Asia/Karachi"' +
    '},' +
    '"location": {' +
        '"displayName": "HawkLogix Pakistan"' +
    '},' +
    '"attendees": [' +
        '{' +
            '"emailAddress": {' +
                '"address": "sufyan@hawklogix.com",' +
                '"name": "Sufyan Ashraf"' +
            '},' +
            '"type": "required"' +
        '}' +
    '],' +
    '"allowNewTimeProposals": true,' +
    '"isOnlineMeeting": true,' +
    '"onlineMeetingProvider": "teamsForBusiness"' +
'}');        

        System.debug('Body: ' + req.getBody());

        System.debug('Endpoint Value: '+ req.getEndpoint());

        System.debug('Request: ' + req);

        HTTPResponse res = http.send(req);

        System.debug('Response Body: '+res.getBody());

        /* Parse Response */

        JSONParser parser = JSON.createParser(res.getBody());

        String webLink;

        webLink = 'MSTeamsNotSetup';

        while (parser.nextToken() != null) {

        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&

        (parser.getText() == 'joinUrl')) {

            parser.nextToken();

            webLink = parser.getText();

            System.debug('joinUrl= ' + webLink);

            }

        }

        return webLink;

    }

}