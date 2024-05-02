public class TestZoomApi {
  
    public static void getmeetingId()
    {
        String meetId = getMeetingUrl();
        System.debug('meetId=>' + meetId);
        //registrantsRequest(meetId);
    }

   public static String getMeetingUrl()

   {

       HttpRequest req = new HttpRequest();

       Http http = new Http();

       //Setup the Endpoint and append the name of the file

       req.setEndpoint('callout:Zoom/users/me/meetings');

       req.setMethod('POST');

       req.setHeader('Content-Type','application/json');

       req.setHeader('Accept','*/*');

       req.setHeader('Accept-Encoding','gzip, deflate, br');

       //Setup the JSON Body – in the test just set a subject, can add more through Postman or other tests

       req.setBody( '{'+
  						'"agenda": "My Meeting",'+
    					'"default_password": false,'+
  						'"duration": 60,'+
  						'"password": "123456",'+
  						'"pre_schedule": false,'+
  						//'"schedule_for": "sufyanashraf5469@gmail.com",'+
  						'"settings": {'+
    						'"allow_multiple_devices": true,'+
    						//'"alternative_hosts": "sufyan@hawklogix.com",'+
    						//'"alternative_hosts_email_notification": true,'+
    						'"approval_type": 2,'+
    						'"audio": "telephony",'+
    						'"audio_conference_info": "test",'+
    						//'"authentication_domains": "example.com",'+
    						//'"authentication_exception": ['+
      						//'{'+
        						//'"email": "jchill@example.com",'+
        						//'"name": "Jill Chill"'+
      						//'}'+
    						//'],'+
    						//'"authentication_option": "signIn_D8cJuqWVQ623CI4Q8yQK0Q",'+
    						'"auto_recording": "cloud",'+
    						'"breakout_room": {'+
      						'"enable": true,'+
      						'"rooms": ['+
        						'{'+
          						'"name": "room1",'+
          						'"participants": ['+
            						'"sufyanashraf5469@gmail.com"'+
          						']'+
        						'}'+
      						']'+
    						'},'+
    						'"calendar_type": 1,'+
    						'"close_registration": false,'+
    						'"contact_email": "sufyanashraf5469@gmail.com",'+
    						'"contact_name": "Jill Chill",'+
    						'"email_notification": true,'+
    						'"encryption_type": "enhanced_encryption",'+
    						'"focus_mode": true,'+
    						//'"global_dial_in_countries": ['+
      						//'"US"'+
    						//'],'+
    						'"host_video": true,'+
    						'"jbh_time": 0,'+
    						'"join_before_host": false,'+
    						'"meeting_authentication": true,'+
    						'"meeting_invitees": ['+
      						'{'+
        						'"email": "sufyanashraf5469@gmail.com"'+
      						'}'+
    						'],'+
    						'"mute_upon_entry": false,'+
    						'"participant_video": false,'+
    						'"private_meeting": false,'+
    						'"registrants_confirmation_email": true,'+
    						'"registrants_email_notification": true,'+
    						'"registration_type": 1,'+
    						'"show_share_button": true,'+
    						'"use_pmi": false,'+
    						'"waiting_room": false,'+
    						'"watermark": false,'+
    						'"host_save_video_order": true,'+
    						'"alternative_host_update_polls": true,'+
    						'"internal_meeting": false,'+
    						'"continuous_meeting_chat": {'+
      						'"enable": true,'+
      						'"auto_add_invited_external_users": true'+
    						'},'+
    						'"participant_focused_meeting": false,' +
    						'"push_change_to_calendar": false,'+
    						'"resources": ['+
      						'{'+
        						'"resource_type": "whiteboard",'+
        						'"resource_id": "X4Hy02w3QUOdskKofgb9Jg",'+
        						'"permission_level": "editor"'+
      						'}'+
    						']'+
  						'},'+
  						'"start_time": "2024-03-04T18:32:55Z",'+
  						'"template_id": "Dv4YdINdTk+Z5RToadh5ug==",'+
						'"timezone": "America/Los_Angeles",'+
  						'"topic": "My Meeting",'+
  						'"type": 2'+
			'}');       

       //req.setBody(‘{}’);
		//req.setBody('{"topic": "Sample Meeting", "type": 2, "start_time": "2024-02-20T13:00:00Z"}');
       System.debug('Body: ' + req.getBody());

       System.debug('Endpoint Value: '+ req.getEndpoint());

       System.debug('Request: ' + req);

       HTTPResponse res = http.send(req);

       System.debug('Response Body: '+res.getBody());

       /* Parse Response */

       JSONParser parser = JSON.createParser(res.getBody());

       String webLink;

       webLink = 'ZoomNotSetup';

       while (parser.nextToken() != null) {

       if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&

       (parser.getText() == 'join_url')) {

           parser.nextToken();

           webLink = parser.getText();

           System.debug('join_url= ' + webLink);

           }

       }

   return webLink;

   }
   
    public static void registrantsRequest(String meetId)
    {
        System.debug('In function');
         HttpRequest req = new HttpRequest();

       Http http = new Http();

       //Setup the Endpoint and append the name of the file

       req.setEndpoint('callout:Zoom/meetings/' + meetId + '/registrants');

       req.setMethod('POST');

       req.setHeader('Content-Type','application/json');

       req.setHeader('Accept','*/*');

       req.setHeader('Accept-Encoding','gzip, deflate, br');

       //Setup the JSON Body – in the test just set a subject, can add more through Postman or other tests

       req.setBody( '{"email":"sufyanashraf5469@gmail.com", "first_name": "Sufyan", "last_name": "Ashraf"}');       

       //req.setBody(‘{}’);

       System.debug('Body: ' + req.getBody());

       System.debug('Endpoint Value: '+ req.getEndpoint());

       System.debug('Request: ' + req);

       HTTPResponse res = http.send(req);

       System.debug('Response Body: '+res.getBody());

       /* Parse Response */

       JSONParser parser = JSON.createParser(res.getBody());

       String webLink;

       webLink = 'ZoomNotSetup';

       while (parser.nextToken() != null) {

       if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&

       (parser.getText() == 'join_url')) {

           parser.nextToken();

           webLink = parser.getText();

           System.debug('join_url= ' + webLink);

           }

       }


    }
    


   
}