global class EmailInboundService implements Messaging.InboundEmailHandler { 
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) { 
   
      Messaging.InboundEmailResult result = new Messaging.InboundEmailResult(); 
        Account obj = new Account(Name = 'Test Email Service');
        obj.Description = email.plainTextBody;
        insert obj;
        /* 
      Claim__c claimObj = new Claim__c();  
      claimObj.Subject__c = email.subject;  
        String[] nameParts = email.fromName.split(' ');
        if (nameParts.size() > 0) {
            claimObj.Name = nameParts[0];
            if (nameParts.size() > 1) {
                claimObj.Name += ' ' + nameParts[nameParts.size()-1];
            }
        }
       
        String emailA = email.fromAddress;
		if (emailA.contains('<')) {
  		emailA = emailA.substring(emailA.indexOf('<')+1, emailA.indexOf('>'));
}
      claimObj.From__c = emailA;
      claimObj.Body__c = email.plainTextBody;  
      
      String phoneRegex = '\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4}(?:[ ]?\\d{1,2})?)';
 
      String emailBody = email.plainTextBody;
      Pattern phonePattern = Pattern.compile(phoneRegex);
      Matcher phoneMatcher = phonePattern.matcher(emailBody);
      List<String> phoneNumbers = new List<String>();
        
        while (phoneMatcher.find()) {
            String phoneNumber = phoneMatcher.group(0);
            phoneNumbers.add(phoneNumber);
        }  
        if (!phoneNumbers.isEmpty()) {
            
    	claimObj.phone__c = phoneNumbers[0];
}
        // Get the PO number from the email body
        String poRegex = '(?i)\\b(?:PO|i|po\\s+num)\\s*(?:number\\s*)?(?:no\\.\\s*)?(?:is\\s*)?(\\d+)\\b';
        String poNumberRegex = '(?i)\\b(?:purchase\\sorder|purchase\\sorder\\snumber)\\s*(?:no\\.\\s*)?(?:is\\s*)?(\\d+)\\b'; 
        Pattern poPattern = Pattern.compile(poRegex);
        Pattern poNumberPattern = Pattern.compile(poNumberRegex);
        Matcher poMatcher = poPattern.matcher(emailBody);
        Matcher poNumberMatcher = poNumberPattern.matcher(emailBody);
        String poNumber = null;
        String poOrderNumber = null;
        
        if (poMatcher.find()) { 
            poNumber = poMatcher.group(1);
        }
        
        if (poNumberMatcher.find()) { 
            poOrderNumber = poNumberMatcher.group(1);
        } 
        
        // Set the PO number and Purchase Order number on the email object
        if (poNumber != null) {
            claimObj.PO_c__c = poNumber;
        }
        
        if (poOrderNumber != null) {
            claimObj.PO_c__c = poOrderNumber;
        }    
           
      	insert claimObj;
        
        if (email.binaryAttachments != null && email.binaryAttachments.size()> 0){
            
            for (integer i = 0; i< email.binaryAttachments.size(); i++){
                Attachment attachment = new Attachment();
                attachment.ParentId = claimObj.Id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.Body = email.binaryAttachments[i].body;
                
                insert attachment;
                
            }
        }
   */ 
        return result; 

    } 
}