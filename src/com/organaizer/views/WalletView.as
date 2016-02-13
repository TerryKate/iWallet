package com.organaizer.views
{
    import starling.display.Sprite;

    public class WalletView extends BaseView
    {
        public function WalletView()
        {
            super()
        }

        public var map:Map = new Map();
        private var header:Header = new Header();
        private var footer:Sprite = new Sprite();

        override public function create():void
        {
            super.create();

            addChild(map);
            addChild(header);
            addChild(footer);
        }
    }
}
