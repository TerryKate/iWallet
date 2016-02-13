/**
 *
 *
 *
 */
package com.organaizer.views
{
    import com.organaizer.constants.C_Color;
import com.organaizer.events.CommEvent;
import com.organaizer.events.NavigationEvent;
import com.greensock.TweenMax;

    import starling.display.Button;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.TouchEvent;
    import starling.filters.BlurFilter;

    public class NavigationView extends BaseView
    {
        public function NavigationView(_state:String)
        {
            super();
            state = _state;
        }

        private var _state:String;

        private var backSwap:Quad;
        private var expanded:Boolean=false;
        private var headerSprite:Sprite;
        private var footerSprite:Sprite;
        private var headerBackground:Quad;
        private var subButton:Button;


        override public function create():void
        {
            super.create();
            this.drawHeader();
        }

        private function drawHeader():void
        {
            var bottomColor:uint = C_Color.LIGHT_GREY;
            var topColor:uint    = C_Color.LIGHT_GREY_GRADIENT;

            headerSprite = new Sprite();
            addChild(headerSprite);

            footerSprite = new Sprite();
            addChild(footerSprite);


            var divisionBackground:Quad = new Quad(layout.relativeWidth(100), layout.relativeWidth(HEADER_SIZE)*3,C_Color.WHITE);
                layout.setFilter(divisionBackground,true,BlurFilter.createGlow(C_Color.GREY, 1.25, .25, .65));
                layout.verticalAlignBottom(divisionBackground, visViewPort);
                layout.horizontalAlignLeft(divisionBackground);
                divisionBackground.alpha = .9;
            footerSprite.addChild(divisionBackground);

            drawFooterButtons();

            backSwap = new Quad(layout.relativeWidth(100),layout.relativeHeight(100));
            backSwap.touchable=false;
            backSwap.alpha = 0;
            headerSprite.addChild(backSwap);


            headerBackground = new Quad(layout.relativeWidth(100), layout.relativeHeight(HEADER_SIZE),C_Color.HEADER);
                headerBackground.setVertexColor(0, C_Color.WHITE);
                headerBackground.setVertexColor(1, C_Color.WHITE);
                headerBackground.setVertexColor(2, topColor);
                headerBackground.setVertexColor(3, bottomColor);
                layout.horizontalAlignCenter(headerBackground);
                layout.verticalAlignTop(headerBackground);
            headerSprite.addChild(headerBackground);


            setFilter(headerBackground,true,BlurFilter.createGlow(C_Color.GREY, 2.5, .65, .45))

            subButton = new Button(assetManager.assetManager.getTexture("sub"));
            subButton.alignPivot();
                layout.proportionHeightScale(subButton,headerBackground.bounds,55);
                layout.horizontalAlignLeft(subButton,headerBackground.bounds, 3);
                layout.verticalAlignMiddle(subButton, headerBackground.bounds);
                subButton.x = subButton.x - subButton.width;
                subButton.y = subButton.y - subButton.height;
                subButton.alpha = .45;
                subButton.addEventListener(Event.TRIGGERED, onMenuTriggered);
            headerSprite.addChild(subButton);
        }


        private function onMenuTriggered(e:Event):void
        {
            subButton.touchable = false;

            if(!expanded)
            {
                TweenMax.to(headerBackground, .3, {height: layout.relativeHeight(HEADER_SIZE) * 2});
                backSwap.addEventListener(TouchEvent.TOUCH, function():void{onMenuTriggered(null);trace("touchhh")});
                expanded = true;
                TweenMax.delayedCall(.3,function():void
                {
                    subButton.touchable = true;
                })
            }
            else
            {
                backSwap.removeEventListeners();
                TweenMax.to(headerBackground, .3, {height: layout.relativeHeight(HEADER_SIZE)});
                expanded = false;
                TweenMax.delayedCall(.3,function():void
                {
                    subButton.touchable = true;
                })
            }
            backSwap.touchable = expanded;
        }

        private function drawFooterButtons():Boolean
        {
              switch(state)
              {
                  case "login":
                      var loginSprite:Sprite = footerSpriteFactory("task_open_ico", "right");
                          loginSprite.addEventListener(Event.TRIGGERED,function(e:Event){dispatcher.dispatchEvent(new CommEvent(CommEvent.IDENT_REQUEST))});
                          footerSprite.addChild(loginSprite);
                  break;

                  case "tasklist":
                      var backSprite:Sprite = footerSpriteFactory("back_ico", "left");
                          backSprite.addEventListener(Event.TRIGGERED,function(e:Event){dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO_VIEW, true,WalletView))});
                          footerSprite.addChild(backSprite);
                  break;

                  case "attachmentlist":
                      var backButtonBackground:Quad = new Quad(layout.relativeWidth(20), layout.relativeWidth(HEADER_SIZE)*3,C_Color.WHITE);
                          layout.setFilter(backButtonBackground,true,BlurFilter.createGlow(C_Color.GREY, 1.25, .25, .65));
                          layout.verticalAlignBottom(backButtonBackground, visViewPort);
                          backButtonBackground.alpha = .9;
                      footerSprite.addChild(backButtonBackground);

                      var backButton:Button = new Button(assetManager.assetManager.getTexture("back_ico"));
                        layout.proportionHeightScale(backButton, backButtonBackground.bounds, 60);
                        layout.verticalAlignMiddle(backButton, backButtonBackground.bounds);
                        layout.horizontalAlignCenter(backButton, backButtonBackground.bounds);
                        backButton.alpha = .35;
                      footerSprite.addChild(backButton);
                  break;

                  default :
                      trace('default');
                  break;
              }


            return true;
        }

        private function footerSpriteFactory(icon:String, position:String):Sprite
        {
            var sp:Sprite = new Sprite;
            var backButtonBackground:Quad = new Quad(layout.relativeWidth(20), layout.relativeWidth(HEADER_SIZE)*3,C_Color.WHITE);
                layout.setFilter(backButtonBackground,true,BlurFilter.createGlow(C_Color.GREY, 1.25, .25, .65));
                layout.verticalAlignBottom(backButtonBackground, visViewPort);
                if (position == "left")
                {
                    layout.horizontalAlignLeft(backButtonBackground);
                }
                else if (position == "right")
                {
                    layout.horizontalAlignRight(backButtonBackground);
                }

                backButtonBackground.alpha = .9;
            sp.addChild(backButtonBackground);


            var backButton:Button = new Button(assetManager.assetManager.getTexture(icon));
                layout.proportionHeightScale(backButton, backButtonBackground.bounds, 60);
                layout.verticalAlignMiddle(backButton, backButtonBackground.bounds);
                layout.horizontalAlignCenter(backButton, backButtonBackground.bounds);
                backButton.alpha = .35;
            sp.addChild(backButton);


            return sp;
        }



        public function get state():String {
            return _state;
        }

        public function set state(value:String):void {
            _state = value;
        }
    }
}
