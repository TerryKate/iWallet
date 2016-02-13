package com.organaizer.data
{

    import starling.events.Event;

    public class CommMessage extends Event
    {
        public static const ALERT_MESSAGE:String = "ALERT_MESSAGE";

        public function CommMessage(type:String,  message_:String="")
        {
            super(type, false, message_);

        }
    }
}
