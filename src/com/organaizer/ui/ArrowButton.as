package com.organaizer.ui
{
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;

    import organaizer.Assets;
    import organaizer.Interface;

    public class ArrowButton extends Interface
    {
        public static const TAP:String = "buttonTap";

        public static const LEFT:String = "L";
        public static const RIGHT:String = "R";

        private var assetManager:Assets;
        private var _bounds:Rectangle;

        private var upState:Bitmap;
        private var arrowIcon:Bitmap;
        private var overState:Bitmap;

        private var direction:String;

        public function ArrowButton(_assetManager:Assets, _direction:String="L")
        {
            this.assetManager = _assetManager;
            this.direction = _direction;

            this.addStates();
            this.addEvents();

            this.addEventListener(Event.ENTER_FRAME, init);
        }


        public function init(e:Event):void
        {
            this.removeEventListener(Event.ENTER_FRAME, init);


        }

        private function addStates():void
        {
            this.overState =    assetManager.createBitmap("ArrowButton"+direction+"press");
            this.upState   =    assetManager.createBitmap("ArrowButton"+direction);
            this.arrowIcon =    assetManager.createBitmap("Arrow"+direction);

            this.addChild(overState);
            this.addChild(upState);
            this.addChild(arrowIcon);

            _bounds = getBounds(upState);

            setState(upState);
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
        private function onPress(event:MouseEvent):void { setState(upState); }
        private function onHover(event:MouseEvent):void { setState(overState); }

        private function setState(_state:Bitmap):void
        {
            this.overState.visible = (overState == _state);
            this.upState.visible = (upState == _state);
        }


        public function get bounds():Rectangle {
            return _bounds;
        }

        public function set bounds(value:Rectangle):void {
            _bounds = value;
        }
    }
}
