/**
 * Created by Auto on 31.3.2015 г..
 */
package com.organaizer.renders
{
    import com.organaizer.controllers.AssetsController;
    import com.organaizer.controllers.InterfaceFactory;
    import com.organaizer.controllers.LayoutController;

    import starling.events.EventDispatcher;

    import flash.geom.Point;

    import feathers.controls.List;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.core.FeathersControl;

    import starling.display.DisplayObject;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class BaseRender extends FeathersControl implements IListItemRenderer
    {
    [Dispatcher]
    public var dispatcher:EventDispatcher;
    [Inject]
    public var layout:LayoutController;

    [Inject]
    public var factory:InterfaceFactory;

    [Inject]
    public var assetManager:AssetsController;

    protected var _index:int = -1;
    protected var _owner:feathers.controls.List;
    protected var _data:Object;
    protected var _isSelected:Boolean;
    protected var _padding:Number = 0;
    protected var touchID:int = -1;

    private static const HELPER_POINT:Point = new Point();

    public function get index():int
    {
        return this._index;
    }


    public function set index(value:int):void
    {
        if(this._index == value)
        {
            return;
        }
        this._index = value;
        this.invalidate(INVALIDATION_FLAG_DATA);
    }


    public function get owner():feathers.controls.List
    {
        return this._owner;
    }

    public function set owner(value:feathers.controls.List):void
    {
        if(this._owner == value)
        {
            return;
        }
        this._owner = value;
        this.invalidate(INVALIDATION_FLAG_DATA);
    }


    public function get data():Object
    {
        return this._data;
    }

    public function set data(value:Object):void
    {
        if(this._data == value)
        {
            return;
        }
        this._data = value;
        this.invalidate(INVALIDATION_FLAG_DATA);
    }


    public function get isSelected():Boolean
    {
        return this._isSelected;
    }

    public function set isSelected(value:Boolean):void
    {
        if(this._isSelected == value)
        {
            return;
        }
        this._isSelected = value;
        this.invalidate(INVALIDATION_FLAG_SELECTED);
        this.dispatchEventWith(Event.CHANGE);
    }


    override protected function initialize():void
    {
        this.addEventListener(TouchEvent.TOUCH, touchHandler);
    }


    protected function commitData():void
    {
        if(this._data)
        {

        }
        else
        {

        }
    }


    public function get padding():Number
    {
        return this._padding;
    }


    public function set padding(value:Number):void
    {
        if(this._padding == value)
        {
            return;
        }
        this._padding = value;
        this.invalidate(INVALIDATION_FLAG_LAYOUT);
    }


    protected function autoSizeIfNeeded():Boolean
    {
        /*var needsWidth:Boolean = isNaN(this.explicitWidth);
         var needsHeight:Boolean = isNaN(this.explicitHeight);
         if(!needsWidth && !needsHeight)
         {
         return false;
         }                                          */

        var newWidth:Number = this.explicitWidth;
        var newHeight:Number = this.explicitHeight;

        return this.setSizeInternal(newWidth, newHeight, false);
    }


    override protected function draw():void
    {
        var dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);

        if(dataInvalid)
        {
            this.commitData();
        }

        this.autoSizeIfNeeded();
        this.layoutChildren();
    }


    protected function layoutChildren():void
    {

    }


    protected function touchHandler(event:TouchEvent):void
    {
        if(!this._isEnabled)
        {
            // if we were disabled while tracking touches, clear the touch id.
            this.touchID = -1;
            return;
        }

        this.touchID = event.touches[0].id;

        if( this.touchID >= 0 )
        {
            // a touch has begun, so we'll ignore all other touches.

            var touch:Touch = event.getTouch(this, TouchPhase.ENDED, this.touchID );
            if( !touch )
            {
                // this should not happen.
                return;
            }

            //if( touch.phase == TouchPhase.ENDED )
            //	{
            touch.getLocation( this.stage, HELPER_POINT );
            var isInBounds:Boolean = this.contains( this.stage.hitTest( HELPER_POINT, true ) );
            if( isInBounds )
            {
                this.isSelected = !this.isSelected;
            }

            // the touch has ended, so now we can start watching for a new one.
            this.touchID = -1;
            //	}
        }
        else
        {
            // we aren't tracking another touch, so let's look for a new one.

            touch = event.getTouch( this, TouchPhase.BEGAN );
            if( !touch )
            {
                // we only care about the began phase. ignore all other phases.
                return;
            }

            // save the touch ID so that we can track this touch's phases.
            this.touchID = touch.id;
        }
    }


}
}
