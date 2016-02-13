package com.organaizer.views
{
import com.organaizer.constants.C_Calendar;

import starling.display.Button;


import starling.display.Image;
    import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class Header extends BaseView
    {

        public var headerBtn:Button;
        private var headerTexture:Image;
        private var footerTexture:Image;
        private var headerTitle:TextField;
        private var footerTitle:TextField;
        private var dateTitle:TextField;

        public function Header()
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
            // Header
            headerTexture = assetManager.getImage("header");
            layout.proportionWidthScale(headerTexture, layout.hudRectangle, 100);
            layout.horizontalAlignCenter(headerTexture, layout.hudRectangle);
            layout.verticalAlignTop(headerTexture, layout.hudRectangle);

            addChild(headerTexture);

            headerTitle = new TextField(layout.relativeWidth(34, headerTexture.bounds),layout.relativeHeight(60, headerTexture.bounds),"");
            headerTitle.x = headerTexture.x + layout.relativeWidth(13, headerTexture.bounds);
            headerTitle.y = headerTexture.y  + layout.relativeHeight(14, headerTexture.bounds);
            //headerTitle.border = true;
            headerTitle.text = "BALANCE";
            headerTitle.fontName = layout.font;
            headerTitle.fontSize = 10;
            headerTitle.hAlign = HAlign.CENTER;
            headerTitle.vAlign = VAlign.CENTER;
            headerTitle.color = 0x005c0f;//0x949695;

            addChild(headerTitle);

            dateTitle = new TextField(layout.relativeWidth(34, headerTexture.bounds),layout.relativeHeight(18, headerTexture.bounds),"");
            dateTitle.x = headerTexture.x + layout.relativeWidth(13, headerTexture.bounds);
            dateTitle.y = headerTexture.y  + layout.relativeHeight(56, headerTexture.bounds);
            dateTitle.text = C_Calendar.MONTHS[new Date().month].label +" "+ String(new Date().date);
            //dateTitle.border = true;
            dateTitle.fontName = layout.font;
            dateTitle.fontSize = 6;
            dateTitle.hAlign = HAlign.CENTER;
            dateTitle.vAlign = VAlign.CENTER;
            dateTitle.color = 0x544b2e;

            addChild(dateTitle);

            headerBtn = new Button(assetManager.getTexture("button"), "ADD");
            layout.horizontalAlignCenter(headerBtn, layout.hudRectangle);
            layout.verticalAlignTop(headerBtn, layout.hudRectangle, 18);
            headerBtn.x += headerBtn.width*.5;
            headerBtn.fontName = layout.font;
            headerBtn.fontColor = 0x19190d;
            headerBtn.fontSize = 14;

            addChild(headerBtn);

            layout.proportionWidthScale(headerBtn, headerTexture.bounds, 36);

            //var headerBtnTitle = new TextField(layout.relativeWidth(34, headerTexture.bounds),layout.relativeHeight(20, headerTexture.bounds),"");


            footerTexture = assetManager.getImage("footer");
            layout.proportionWidthScale(footerTexture, layout.menuRectangle, 100);
            layout.horizontalAlignCenter(footerTexture, layout.menuRectangle);
            layout.verticalAlignBottom(footerTexture, layout.menuRectangle);
            addChild(footerTexture);

            footerTitle = new TextField(layout.relativeWidth(100, headerTexture.bounds),layout.relativeHeight(80, footerTexture.bounds),"");
            footerTitle.x = footerTexture.x;
            footerTitle.y = footerTexture.y  + layout.relativeHeight(20, footerTexture.bounds);
            footerTitle.text = "1200.00";
            //dateTitle.border = true;
            footerTitle.fontName = layout.font;
            footerTitle.fontSize = 16;
            footerTitle.hAlign = HAlign.CENTER;
            footerTitle.vAlign = VAlign.CENTER;
            footerTitle.color = 0xFFFFFF;
            footerTitle.alpha = .35;

            addChild(footerTitle);
        }
    }
}
