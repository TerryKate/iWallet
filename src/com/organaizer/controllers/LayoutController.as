package com.organaizer.controllers
{
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.Font;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.filters.BlurFilter;


public class LayoutController
{
    //where Starling draws
    public var viewPort:Rectangle;
    public var nativeStageAspect:Number;

    // the part of viewPort that is visible
    public var visibleViewPort:Rectangle;
    public var visibleAspect:Number;

    public var currentLayout:int;

    public static const PHONE_LAYOUT:int = 0;
    public static const TABLET_LAYOUT:int = 1;

    public static var TOOLTIP_TEXT_SIZE:Number;

    public var menuRectangle:Rectangle;
    public var hudRectangle:Rectangle;
    public var mainRectangle:Rectangle;

    public var mainMenuButtonSize:Number;

    public function LayoutController()
    {
        this.viewPort = new Rectangle(0,0,Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);

        var x:Number = ((Starling.current.stage.stageWidth*Starling.current.contentScaleFactor - Starling.current.nativeStage.stageWidth)/2)/Starling.current.contentScaleFactor;
        var y:Number = Starling.current.stage.y;// ((Starling.current.stage.stageHeight*Starling.current.contentScaleFactor - Starling.current.nativeStage.stageHeight)/2)/Starling.current.contentScaleFactor;

        var width:Number = Starling.current.nativeStage.stageWidth/Starling.current.contentScaleFactor;
        var height:Number = Starling.current.nativeStage.stageHeight/Starling.current.contentScaleFactor;

        this.visibleViewPort = new Rectangle(x,y,width,height);
        this.visibleAspect = width/height;

        if (this.nativeStageAspect>1.4)
        {
            this.currentLayout = PHONE_LAYOUT;
        }
        else
        {
            this.currentLayout = TABLET_LAYOUT;

        }
        /**
            this.menuRectangle = new Rectangle(relativeX(0),relativeY(0),relativeWidth(12),relativeHeight(100));
            this.hudRectangle = new Rectangle(relativeX(12),relativeY(0),relativeWidth(88),relativeHeight(10));
            this.mainRectangle = new Rectangle(relativeX(12),relativeY(10),relativeWidth(88),relativeHeight(90));
            this.mainMenuButtonSize = 10;       ]

             trace("viewPort: " + this.viewPort);
             trace("visibleViewPort: " + this.visibleViewPort);
             trace("menuRectangle: " + this.menuRectangle);
             trace("hudRectangle: " + this.hudRectangle);
             trace("mainRectangle: " + this.mainRectangle);

           */
            this.menuRectangle = new Rectangle(relativeX(0),relativeY(90),relativeWidth(100),relativeHeight(10));
            this.hudRectangle = new Rectangle(relativeX(0),relativeY(0),relativeWidth(100),relativeHeight(8));
            this.mainRectangle = new Rectangle(relativeX(0),relativeY(8),relativeWidth(100),relativeHeight(82));
            this.mainMenuButtonSize = 8;




        TOOLTIP_TEXT_SIZE = relativeHeight(3, this.visibleViewPort);
    }


    public function relativeX(val:Number, rect:Rectangle=null):Number
    {
        if (rect == null)
            rect = this.visibleViewPort;

        return rect.x + rect.width*val/100;
    }


    public function relativeY(val:Number, rect:Rectangle=null):Number
    {
        if (rect == null)
            rect = this.visibleViewPort;

        return rect.y + rect.height*val/100;
    }


    public function relativeWidth(val:Number, rect:Rectangle=null):Number
    {
        if (rect == null)
            rect = this.visibleViewPort;

        return rect.width*val/100;
    }


    public function relativeHeight(val:Number, rect:Rectangle=null):Number
    {
        if (rect == null)
            rect = this.visibleViewPort;

        return rect.height*val/100;
    }


    public function setRelativeSize(displayObject:DisplayObject, relWidth:Number, relHeight:Number, rect:Rectangle):void
    {
        displayObject.width = relativeWidth(relWidth, rect);
        displayObject.height = relativeHeight(relHeight, rect);
    }


    public function scaleToVisibleStage(displayObject:DisplayObject):void
    {
        displayObject.x = relativeX(0, this.visibleViewPort);
        displayObject.y = relativeY(0, this.visibleViewPort);
        displayObject.width = relativeWidth(100, this.visibleViewPort);
        displayObject.height = relativeHeight(100, this.visibleViewPort);
    }


    public static function setToRectangle(displayObject:DisplayObject, rect:Rectangle):void
    {
        displayObject.x = rect.x;
        displayObject.y = rect.y;
        displayObject.width = rect.width;
        displayObject.height = rect.height;
    }

    public function proportionHeightScale(displayObject:DisplayObject, rect:Rectangle, height:Number):void
    {
        var scaleFactor:Number = relativeHeight(height, rect)/displayObject.height;
        displayObject.height*=scaleFactor;
        displayObject.width*=scaleFactor;
    }


    public function proportionWidthScale(displayObject:DisplayObject, rect:Rectangle, width:Number):void
    {
        var scaleFactor:Number = relativeWidth(width, rect)/displayObject.width;
        displayObject.height*=scaleFactor;
        displayObject.width*=scaleFactor;
    }


    public static function absPropHeightScale(displayObject:DisplayObject, height:Number):void
    {
        var scale:Number = height/displayObject.height;
        displayObject.height = height;
        displayObject.width = displayObject.width*scale;
    }


    public static function absPropWidthScale(displayObject:DisplayObject, width:Number):void
    {
        var scale:Number = width/displayObject.width;
        displayObject.width = width;
        displayObject.height = displayObject.height*scale;
    }


    public function proportionScaleToRectangle(displayObject:DisplayObject, rect:Rectangle):void
    {
        var rectAspect:Number = rect.width/rect.height;
        var displayObjAspect:Number = displayObject.width/displayObject.height;

        if (displayObjAspect>rectAspect)
        {
            proportionHeightScale(displayObject, rect, 100);
            verticalAlignMiddle(displayObject, rect);
            horizontalAlignCenter(displayObject, rect);
        }
        else
        {
            proportionWidthScale(displayObject, rect, 100);
            verticalAlignMiddle(displayObject, rect);
            horizontalAlignCenter(displayObject, rect);
        }
    }


    public function horizontalAlignLeft(displayObject:DisplayObject, rect:Rectangle=null, distance:Number=0):void
    {
        displayObject.x = relativeX(0, rect) + relativeWidth(distance, rect) + displayObject.pivotX;
    }


    public function horizontalAlignCenter(displayObject:DisplayObject, rect:Rectangle=null, distance:Number=0):void
    {

        displayObject.x = relativeX(0, rect) + relativeWidth(50 + distance, rect) - (displayObject.width/2) + displayObject.pivotX;
    }


    public function horizontalAlignRight(displayObject:DisplayObject, rect:Rectangle=null, distance:Number=0):void
    {
        var sign:int = !(displayObject.scaleX < 0) ? 1 : 0;
        displayObject.x = relativeX(0, rect) + relativeWidth(100, rect) - (displayObject.width*sign) - relativeWidth(distance, rect) + displayObject.pivotX;
    }


    public function verticalAlignTop(displayObject:DisplayObject, rect:Rectangle=null, distance:Number = 0):void
    {
        displayObject.y = relativeY(0, rect) + relativeHeight(distance, rect) + displayObject.pivotY;
    }


    public function verticalAlignMiddle(displayObject:DisplayObject, rect:Rectangle=null, distance:Number=0):void
    {
        displayObject.y = relativeY(0, rect) + relativeHeight(50+distance, rect) - displayObject.height/2 + displayObject.pivotY;
    }


    public function verticalAlignBottom(displayObject:DisplayObject, rect:Rectangle=null, distance:Number=0):void
    {
        if(!rect) rect = viewPort;
        displayObject.y = relativeY(0, rect) + relativeHeight(100, rect) - displayObject.height - relativeHeight(distance, rect) + displayObject.pivotY;
    }


    public static function getQuadrant(pt:Point):int
    {
        var alignment:int;
        if (pt.x<Starling.current.stage.stageWidth/2 && pt.y<Starling.current.stage.stageHeight/2)
            alignment = 0;
        else if (pt.x<Starling.current.stage.stageWidth/2 && pt.y>=Starling.current.stage.stageHeight/2)
            alignment = 1;
        if (pt.x>=Starling.current.stage.stageWidth/2 && pt.y<Starling.current.stage.stageHeight/2)
            alignment = 2;
        else if (pt.x>=Starling.current.stage.stageWidth/2 && pt.y>=Starling.current.stage.stageHeight/2)
            alignment = 3;

        return alignment;
    }


    // Stretches a DO to rect with relative sizes
    public function setToRelativeRectangle(displayObject:DisplayObject, rect:Rectangle, layoutRect:Rectangle=null):void
    {
        if (layoutRect == null)
            layoutRect = this.visibleViewPort;

        displayObject.x = relativeX(rect.x, layoutRect);
        displayObject.y = relativeY(rect.y, layoutRect);
        displayObject.width = relativeWidth(rect.width, layoutRect);
        displayObject.height = relativeHeight(rect.height, layoutRect);
    }


    // put DO in rect without distortion
    public function putInRectangle(displayObject:DisplayObject, containerRect:Rectangle, layoutRect:Rectangle=null, relSize:Boolean=true, hMargin:Number = 0, vMargin:Number = 0):void
    {
        if (layoutRect == null)
            layoutRect = visibleViewPort;

        containerRect.x += hMargin;
        containerRect.width -= 2*hMargin;
        containerRect.y += vMargin;
        containerRect.height -= 2*vMargin;

        var displayObjectAspect:Number = displayObject.width/displayObject.height;
        var rectAspect:Number;

        if (relSize)
            rectAspect = relativeWidth(containerRect.width,layoutRect)/relativeHeight(containerRect.height, layoutRect);
        else
            rectAspect = containerRect.width/containerRect.height;

        if (displayObjectAspect>rectAspect)
        {
            if (relSize)
            {
                proportionWidthScale(displayObject, layoutRect, containerRect.width);
                displayObject.y = relativeY(containerRect.y, layoutRect) + (relativeHeight(containerRect.height, layoutRect) - displayObject.height)/2 + displayObject.pivotY;
                displayObject.x = relativeX(containerRect.x, layoutRect) + displayObject.pivotX;
            }
            else
            {
                absPropWidthScale(displayObject, containerRect.width);
                displayObject.y = containerRect.y + (containerRect.height - displayObject.height)/2 + displayObject.pivotY;
                displayObject.x = containerRect.x + displayObject.pivotX;
            }
        }
        else
        {
            if (relSize)
            {
                proportionHeightScale(displayObject, layoutRect, containerRect.height);
                displayObject.x = relativeX(containerRect.x, layoutRect) + (relativeWidth(containerRect.width, layoutRect) - displayObject.width)/2 + displayObject.pivotX;
                displayObject.y = relativeY(containerRect.y, layoutRect) + displayObject.pivotY;
            }
            else
            {
                absPropHeightScale(displayObject, containerRect.height);
                displayObject.x = containerRect.x  + (containerRect.width  - displayObject.width)/2 + displayObject.pivotX;
                displayObject.y = containerRect.y + displayObject.pivotY;
            }

        }
    }

    public function alignObjectTo(displayObject:DisplayObject, objectoAligningTo:DisplayObject):void
    {
        displayObject.x = objectoAligningTo.x;
        displayObject.y = objectoAligningTo.y;
    }

    public function setFilter(dispalyObject:DisplayObject, visibility:Boolean=true, filter:BlurFilter=null, color:uint=0xFFFFFF )
    {
        if(!visibility){
            if(dispalyObject.filter){
                dispalyObject.filter.clearCache();
                dispalyObject.filter = null;
            }
            return;
        }
        if(!filter){
            dispalyObject.filter = BlurFilter.createGlow(color, 2.5, .65, .45);
        }
        else{
            dispalyObject.filter = filter;
        }
        dispalyObject.filter.cache();
        return;
    }

    public function get fontSize():Number{
        return relativeHeight(2.2);
    }


    public function get font():String{
        var font:Font = new _fontRoboto;
        return font.fontName;
    }


        [Embed
                (
                source="/../assets/fonts/BlackOpsOne-Regular.ttf",
                fontName = "Roboto",
                mimeType = "application/x-font",
                advancedAntiAliasing="true",
                embedAsCFF="false"
                )]
        private var _fontRoboto:Class;

    }
}