package com.organaizer.ui
{
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;

    import organaizer.Assets;
    import organaizer.Interface;

    public class Button extends Interface
    {
        public static const TAP:String = "buttonTap";

        private var assetManager:Assets;
        private var _bounds:Rectangle;

        private var upState:Bitmap;
        private var downState:Bitmap;
        private var overState:Bitmap;

        private var label:TextField;

        public function Button(_assetManager:Assets)
        {
            this.assetManager = _assetManager;
            this.addStates();
            this.addLabel();
            this.addEvents();

            this.addEventListener(Event.ENTER_FRAME, init);
        }

        public function init(e:Event):void
        {
            this.removeEventListener(Event.ENTER_FRAME, init);
        }

        private function addStates():void
        {
            this.downState =    assetManager.createBitmap("BaseButtonSkin");
            this.overState =    assetManager.createBitmap("BaseButtonPressed");
            this.upState   =    assetManager.createBitmap("BaseButtonSkin");

            this.addChild(overState);
            this.addChild(downState);
            this.addChild(upState);

            _bounds = getBounds(upState);

            setState(upState)
        }

        private function addEvents():void
        {
            this.addEventListener(MouseEvent.CLICK, onTap);
            this.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
            this.addEventListener(MouseEvent.MOUSE_UP, onRelease);
            this.addEventListener(MouseEvent.MOUSE_OVER, onHover);
            this.addEventListener(MouseEvent.MOUSE_OUT, onHoverOut);
        }

        private function onTap(event:MouseEvent):void { dispatchEvent(new Event(TAP)); }
        private function onRelease(event:MouseEvent):void { setState(overState); }
        private function onHoverOut(event:MouseEvent):void { setState(upState); }
        private function onPress(event:MouseEvent):void { setState(downState); }
        private function onHover(event:MouseEvent):void { setState(overState); }

        private function setState(_state:Bitmap):void
        {
            this.overState.visible = (overState == _state);
            this.downState.visible = (downState == _state);
            this.upState.visible = (upState == _state);
        }

        public function addLabel():void
        {
            label = newLabel("Button");
            label.width = upState.width;
            label.height = upState.height;
            this.addChild(label);
        }

        public function get bounds():Rectangle {
            return _bounds;
        }

        public function set bounds(value:Rectangle):void {
            _bounds = value;
        }
    }
}
