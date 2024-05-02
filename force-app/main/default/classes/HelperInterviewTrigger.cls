global with sharing class HelperInterviewTrigger {
      public static void createMSteamsRequest(Interview__c newObj)
    {
          //Interview__c newObj = newInterviewList[0];
          Candidate__c cand = [Select Id, Name, Candidate_Email__c from Candidate__c Where Id =:newObj.Candidate__c];
        
     //   for(Interview__c newObj: interviewList)
     //   {
            //if(newObj.Interview_Location__c == 'Online')
           // {
			MeetingRequestWrapper meeting = new MeetingRequestWrapper();			
			meeting.subject = newObj.Name;
			meeting.body.contentType = 'HTML';
			meeting.body.content = newObj.Interview_Description__c;
			meeting.start.dateTime1 = ToGoogleDateTime(newObj.Interview_Date_Time__c);
			meeting.start.timeZone = 'Asia/Karachi';
			meeting.endDate.dateTime1 = ToGoogleDateTime(newObj.Interview_End_Date_Time__c);
			meeting.endDate.timeZone = 'Asia/Karachi';
			meeting.location.displayName = 'MS Teams';
            if(String.isNotBlank(cand.Candidate_Email__c))
            {
               meeting.attendees.add(new MeetingRequestWrapper.Attendee(cand.Candidate_Email__c, cand.Name, 'required')); 
            }
            if(String.isNotBlank(newObj.First_Attendee__c))
            {
				Attendees__c attendee1 = returnNameEmail(newObj.First_Attendee__c);
                meeting.attendees.add(new MeetingRequestWrapper.Attendee(attendee1.Attendee_Email__c, attendee1.Name, 'required'));
            }
             if(String.isNotBlank(newObj.Second_Attendee__c))
            {
				Attendees__c attendee2 = returnNameEmail(newObj.Second_Attendee__c);
                meeting.attendees.add(new MeetingRequestWrapper.Attendee(attendee2.Attendee_Email__c, attendee2.Name, 'required'));
            }
             if(String.isNotBlank(newObj.Third_Attendee__c))
            {
				Attendees__c attendee3 = returnNameEmail(newObj.Third_Attendee__c);
                meeting.attendees.add(new MeetingRequestWrapper.Attendee(attendee3.Attendee_Email__c, attendee3.Name, 'required'));
            }
            //for(String validEmail : extractEmails(newObj.Attendees_Email__c))
            //{
            //meeting.attendees.add(new MeetingRequestWrapper.Attendee(validEmail, extractBeforeAtSymbol(validEmail), 'required'));
           // }
			//meeting.attendees.add(new MeetingRequestWrapper.Attendee(newObj.Attendees_Email__c, 'Test', 'required'));
			meeting.allowNewTimeProposals = true;
			meeting.isOnlineMeeting = true;
			meeting.onlineMeetingProvider = 'teamsForBusiness';
            String jsonString = meeting.toJsonString();
            jsonString = jsonString.replace('endDate', 'end');
            jsonString = jsonString.replace('dateTime1', 'dateTime');
            postMSMeeting(jsonString,newObj.Id);
        	//}  
        //}
    }
    
		@future (callout=true)
    	public static void postMSMeeting(String body, Id recordId)
        {
        	
			postHttpRequest(body,recordId);
        }
    
    	public static void postHttpRequest(String httpBody, Id recordId)
    	{
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setEndpoint('callout:MS_teams_Calender');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','*/*');
        req.setHeader('Accept-Encoding','gzip, deflate, br');
        req.setBody(httpBody);        
        System.debug('Body: ' + req.getBody());
        System.debug('Endpoint Value: '+ req.getEndpoint());
        System.debug('Request: ' + req);
        HTTPResponse res = http.send(req);
        System.debug('Response Body: '+res.getBody());
        /* Parse Response */
        JSONParser parser = JSON.createParser(res.getBody());
        String webLink;
        webLink = 'MSTeamsNotSetup';
        String EventId;
        while (parser.nextToken() != null) {
        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
        (parser.getText() == 'joinUrl')) {
            parser.nextToken();
            webLink = parser.getText();
            System.debug('joinUrl= ' + webLink);
        }
            
        else if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
        (parser.getText() == 'id')) {
            parser.nextToken();
            EventId = parser.getText();
            System.debug('id= ' + EventId);
            
        }
          
        }
             if(String.isNotBlank(webLink) && String.isNotBlank(EventId))
            {
            Interview__c intrvw = [Select Id, Name,MS_teams_URL__c from  Interview__c where Id =:recordId];
            intrvw.MS_teams_URL__c = webLink;
            intrvw.Ms_teams_Event_Id__c = EventId;
            StopRecursion.isFirstTime = false;
            update intrvw;
                
            }
    	}
    
     public static void attachmentRequest(String recordId)
    {
        
    }
    
    public static String ToGoogleDateTime(DateTime SFTime)
    {
     System.debug('SFTime=>' + SFTime);
    String DateTimeStr = SFTime.format('yyyy-MM-dd HH:mm:ss');
   // Time timeStr = SFTime.time(); 
   	String datePart = DateTimeStr.substring(0, 10);
    String timePart = DateTimeStr.substring(11, 19);
    String calenderDataTime = datePart + 'T' + timePart;
    System.debug('calenderDataTime=>' + calenderDataTime);
    return calenderDataTime;
    }
      
    public static Attendees__c returnNameEmail(Id recordId)
    {
        return [Select Id, Name, Attendee_Email__c from Attendees__c where Id =:recordId];
    }
    
   

}