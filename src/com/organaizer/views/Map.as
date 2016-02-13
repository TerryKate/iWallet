package com.organaizer.views
{
    import com.greensock.TweenMax;
    import com.organaizer.renders.iWalletRender;
    import feathers.controls.List;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import flash.geom.Point;
    import starling.display.Image;
    import starling.display.Sprite;


    public class Map extends BaseView
    {
        private var mapSprite:Sprite = new Sprite();
        private var mapTexture:Image;
        private var walletList:List;
        private var cashList:List;
        private var balancePoint:Point;
        private var cashPoint:Point;

        public function Map()
        {
            super()
        }

        override public function create():void
        {
            super.create();
            this.draw();
        }

        private function draw():void
        {
            // Map
            mapTexture = assetManager.getImage("map");
            mapSprite.addChild(mapTexture);
            addChild(mapSprite);

            drawLists();

            balancePoint = new Point(-(layout.relativeX(30,mapTexture.bounds)),-(layout.relativeY(10,mapTexture.bounds)));
            cashPoint = new Point(-(layout.relativeX(42,mapTexture.bounds)),-(layout.relativeY(5,mapTexture.bounds)));

            TweenMax.to(mapSprite, 1, {x:balancePoint.x, y:mapSprite.y});
            TweenMax.from(walletList, 1, {x:-balancePoint.x, y:-mapSprite.y});
        }

        public function moveMapTo():void
        {
            walletList.visible = false;
            cashList.visible = true;
            TweenMax.to(mapSprite, 1, {x:cashPoint.x, y:mapSprite.y});
            TweenMax.from(cashList, 1, {x:-cashPoint.x, y:-mapSprite.y});
        }

        private function drawLists():void
        {
            walletList = new List();
            walletList.isSelectable = true;
            walletList.hasElasticEdges = true;
            walletList.width = layout.relativeWidth(100);
            walletList.height = layout.relativeHeight(100, layout.mainRectangle);
            layout.horizontalAlignCenter(walletList, layout.mainRectangle);
            layout.verticalAlignTop(walletList, layout.mainRectangle);
            //listRender.addEventListener(Event.CHANGE, onListTrigger );
            //balanceList.verticalScrollBarFactory = factory.simpleScrollBarFactory;
            walletList.itemRendererFactory = function():IListItemRenderer
            {
                return new iWalletRender();
            };

            this.addChild( walletList );
        }


        public function setDataProvider(provider:ListCollection = null):void
        {
            if(walletList)
                this.walletList.dataProvider = provider;
            else
                trace("walletList:null")
        }


    }
}
