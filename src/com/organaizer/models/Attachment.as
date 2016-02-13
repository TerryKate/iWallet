/**
 * Created by Auto on 28.3.2015 г..
 */
package com.organaizer.models
{
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.utils.ByteArray;


    import starling.display.Image;
    import starling.events.EventDispatcher;
    import starling.textures.Texture;

public class Attachment extends BaseModel
{
    public var id:String;
    public var dateCreated:String;
    public var fileName:String;
    public var fileExtension:String;
    public var status:String;
    public var imageXML:XML;
    public var image:Image;
    public var imageBase64:String;
    public var imageBase64raw:ByteArray;

    public var skip:Boolean = false;
    public var uploaded:Boolean = true;

    [Dispatcher]
    public var dispatcher:EventDispatcher;

    public function Attachment()
    {

    }

    public function initFrom(takstToLoad:XML):void
    {
        var i:Number=0;
        var len:Number = getNumberChildElements(takstToLoad);

        for(i;i<len;i++)
        {
            var cypher:String = takstToLoad.child([i]).localName();
            var key = takstToLoad.child([i]);

            if (!cypher) return;  // Serve and protect
            switch (cypher)
            {
                case    ("ItemId"):                   id                = key;        break;
                case    ("CreationDateTime"):         dateCreated       = convertDate(key);        break;
                case    ("FileName"):                 fileName          = key;        break;
                case    ("FileExtension"):            fileExtension     = key;        break;
                case    ("TaskStatus"):               status            = key;        break;
                case    ("Source"):                   imageXML = new XML(takstToLoad.child([i])) ;  return;
            }
        }
    }


    private function loadbytesComplete(e:Event):void
    {
        var src:BitmapData = new BitmapData(e.target.content.width, e.target.content.height);
        src.draw(e.target.content);


        image = new Image(Texture.fromBitmapData(src));
        trace("Umm ok loaded");
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
