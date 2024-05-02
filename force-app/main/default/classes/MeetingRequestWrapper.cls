public class MeetingRequestWrapper {
    public String subject;
    public Body body;
    public StartDateTime start;
    public EndDateTime endDate;
    public Location location;
    public List<Attendee> attendees;
    public Boolean allowNewTimeProposals;
    public Boolean isOnlineMeeting;
    public String onlineMeetingProvider;

    public MeetingRequestWrapper() {
        body = new Body();
        start = new StartDateTime();
        endDate = new EndDateTime();
        location = new Location();
        attendees = new List<Attendee>();
    }

    public String toJsonString() {
        return JSON.serialize(this);
    }

    public class Body {
        public String contentType;
        public String content;
    }

    public class StartDateTime {
        public String dateTime1;
        public String timeZone;
    }

    public class EndDateTime {
        public String dateTime1;
        public String timeZone;
    }

    public class Location {
        public String displayName;
    }

    public class Attendee {
        public EmailAddress emailAddress;
        public String type;
        
        public Attendee(String address, String name, String type) {
            emailAddress = new EmailAddress(address, name);
            this.type = type;
        }
    }

    public class EmailAddress {
        public String address;
        public String name;

        public EmailAddress(String address, String name) {
            this.address = address;
            this.name = name;
        }
    }
}