package com.organaizer.renders
{
    import com.organaizer.constants.C_Color;
    import com.organaizer.models.WalletItem;
    import com.organaizer.views.CallendarView;
import starling.events.TouchPhase;
    import starling.display.Image;
    import starling.display.Quad;
import starling.events.TouchEvent;
import starling.filters.BlurFilter;
    import starling.text.TextField;

    import flash.geom.Rectangle;

    import feathers.controls.renderers.IListItemRenderer;

    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public final class iWalletRender  extends BaseRender implements IListItemRenderer
    {
        internal static var visViewPort:Rectangle;

        private var background:Quad;
        private var iconFrame:Image;
        private var icon:Image;

        private var itemValueTF:TextField;
        private var itemTitleTF:TextField;
        private var itemTotal:TextField;

        override protected function initialize():void
        {
            super.initialize();

            visViewPort = layout.visibleViewPort;
            explicitHeight = layout.relativeHeight(26);


/*
            background = new Quad(layout.relativeWidth(100), explicitHeight,C_Color.HEADER);
            background.setVertexColor(0, C_Color.WHITE);
            background.setVertexColor(1, C_Color.WHITE);
            background.setVertexColor(2, C_Color.LIGHT_GREY_GRADIENT);
            background.setVertexColor(3, C_Color.LIGHT_GREY);
            //setFilter(background,true,BlurFilter.createGlow(C_Color.GREY, 2.5, .65, .45));
            addChild(background);

            //background = new Quad(layout.relativeWidth(100), explicitHeight, 0xF4F0C9);
            //background.alpha=0;
            addChild(background);*/

            this.addEventListener(TouchEvent.TOUCH, onTouch);

            drawComponents();
        }

        private function onTouch(e:TouchEvent):void
        {
            if(e.getTouch(background, TouchPhase.ENDED)) {
                trace('touch> ENDED?')
            }

            if(e.getTouch(background, TouchPhase.BEGAN)) {
                trace('touch> BEGAN?')
            }
        }

        private function drawComponents():void
        {


            itemValueTF = new TextField(layout.relativeWidth(84),explicitHeight,"");
            itemValueTF.text = "200.00";
            itemValueTF.color = 0xd59936;
            itemValueTF.fontName = layout.font;
            itemValueTF.fontSize = 24;
            //itemValueTF.border = true;
            itemValueTF.hAlign = HAlign.RIGHT;
            itemValueTF.vAlign = VAlign.CENTER;
            addChild(itemValueTF);

            itemTitleTF = new TextField(layout.relativeWidth(84),explicitHeight*.4,"");
            itemTitleTF.text = "CASH";
            itemTitleTF.color = 0xd59936;
            itemTitleTF.fontName = layout.font;
            itemTitleTF.fontSize = 7;
            //itemTitleTF.border = true;
            itemTitleTF.hAlign = HAlign.RIGHT;
            itemTitleTF.vAlign = VAlign.BOTTOM;
            addChild(itemTitleTF);

  /**
            iconFrame = assetManager.getImage("icon_bg");
            layout.proportionHeightScale(iconFrame, background.bounds, 60);
            layout.horizontalAlignLeft(iconFrame, background.bounds, 2);
            layout.verticalAlignMiddle(iconFrame, background.bounds, 2);
            //layout.setFilter(iconFrame, true,BlurFilter.createGlow(C_Color.GREY, 1.5, .65, .45));
            //iconFrame.visible = false;
            addChild(iconFrame);


            itemDate = new TextField(200,iconFrame.height,"1 Дек",layout.font, layout.fontSize);
            itemDate.touchable=false;
            itemDate.color = C_Color.BLACK;
            itemDate.hAlign = HAlign.LEFT;
            itemDate.vAlign = VAlign.CENTER;
            itemDate.touchable = false;
            itemDate.x = iconFrame.x+iconFrame.width;
            itemDate.y = iconFrame.y+iconFrame.height-itemDate.height;
            addChild(itemDate);


            itemTitle = new TextField(background.width,iconFrame.height,"Заплата",layout.font, layout.fontSize);
            itemTitle.touchable=false;
            itemTitle.color = C_Color.BLACK;
            itemTitle.hAlign = HAlign.LEFT;
            itemTitle.vAlign = VAlign.CENTER;
            itemTitle.x = itemDate.x+itemDate.width;
            itemTitle.y = iconFrame.y+iconFrame.height-itemTitle.height;
            addChild(itemTitle);


            itemTotal = new TextField(background.width*.2,iconFrame.height,"100.00 лв.",layout.font, layout.fontSize);
            itemTotal.touchable=false;
            itemTotal.color = C_Color.BATTERY_GREEN;
            itemTotal.hAlign = HAlign.LEFT;
            itemTotal.vAlign = VAlign.CENTER;
            itemTotal.touchable = false;
            layout.horizontalAlignRight(itemTotal, background.bounds, 2);
            layout.verticalAlignMiddle(itemTotal, background.bounds);
            addChild(itemTotal);

            */
        }

        override protected function commitData():void
        {
            if(!_data)
            {
                trace("CommitError");
                return;
            }

            var item:WalletItem = _data as WalletItem;
            if(item)trace(item.id);
            itemValueTF.text = String(item.value);

            //setIcon(item.icon);
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

        public function iWalletRender()
        {
        }
    }
}
