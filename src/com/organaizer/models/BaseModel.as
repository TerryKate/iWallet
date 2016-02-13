/**
 * Created by Auto on 28.3.2015 г..
 */
package com.organaizer.models
{
import starling.events.EventDispatcher;


public class BaseModel
{


    public function BaseData()
    {

    }

    public function convertDate(dateString:String):String
    {
        return dateString.slice(0,10);
    }

    public static function getNumberChildElements(node:XML):int{
        var count:int = 0;
        for (var i:int=0; i<node.children().length(); i++){
            if (node.children()[i].nodeKind() == "element")
                count++;
        }
        return count;
    }
}
}
