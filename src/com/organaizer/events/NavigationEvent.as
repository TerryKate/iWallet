package com.organaizer.events
{
import starling.events.Event;

public class NavigationEvent extends Event
{
    public static const NAVIGATE_TO_VIEW:String = "NAVIGATE_TO_VIEW";
    public static const ADD_VIEW:String = "ADD_VIEW";

    private var _viewClass:Class;

    public function NavigationEvent(type:String, bubbles:Boolean=false, viewClass:Class=null, data_:Object = null)
    {
        super(type, bubbles, data_);
        _viewClass = viewClass
    }

    public function get viewClass():Class
    {
        return _viewClass;
    }
}
}
