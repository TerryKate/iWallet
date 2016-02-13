package com.organaizer.events
{
import starling.events.Event;

public class CommEvent extends Event
{

    public static const SELECT_SERVER:String = "SELECT_SERVER";
    public static const SELECT_UPLOAD:String = "SELECT_UPLOAD";

    public static const IDENT_REQUEST:String = "IDENT_REQUEST";
    public static const IDENT_LOGIN:String = "IDENT_LOGIN";
    public static const IDENT_FAILED:String = "IDENT_FAILED";
    public static const IDENT_SUCCSEFUEL:String = "IDENT_SUCCSEFUEL";

    public static const REQUEST_TASK_DETAILS:String = "REQUEST_TASK_DETAILS";
    public static const REQUEST_TASK_ATTACHMENTS:String = "REQUEST_TASK_ATTACHMENTS";
    public static const REQUEST_ATTACHMENT_PHOTO:String = "REQUEST_ATTACHMENT_PHOTO";

    public function CommEvent(type:String, bubbles:Boolean=false, data_:Object = null)
    {
        super(type, bubbles, data_);

    }

}
}
