/**
 * Created by Projects on 21.11.2014 г..
 */
package com.organaizer.views
{
    import com.organaizer.constants.C_Color;
    import com.organaizer.constants.C_Font;
    import com.organaizer.controllers.AssetsController;
    import com.organaizer.controllers.InterfaceFactory;
    import com.organaizer.controllers.LayoutController;
    import com.organaizer.controllers.LocalDataController;
    import com.organaizer.data.CommMessage;
    import com.greensock.TweenMax;
    import com.greensock.easing.Strong;

    import flash.geom.Rectangle;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.EventDispatcher;
    import starling.filters.BlurFilter;
    import starling.text.TextField;
    import starling.utils.HAlign;

    public class BaseView extends Sprite
    {
        [Dispatcher] public var dispatcher:EventDispatcher;

        [Inject] public var assetManager:AssetsController;
        [Inject] public var layout:LayoutController;
        [Inject] public var factory:InterfaceFactory;
        [Inject] public var localDataController:LocalDataController;
        //[Inject] public var locale:LanguageController;

        public static const HEADER_SIZE:Number=6;

        public var visViewPort:Rectangle;
        private var loadingCircle:Sprite;

        public function create():void
        {
            visViewPort = layout.visibleViewPort;
            this.addEventListener(CommMessage.ALERT_MESSAGE, systemMessageEvent)
        }


        private function systemMessageEvent(event:CommMessage):void
        {
            systemMessage(event.data as String);
        }


        public function getDefaultButton(label:String = "", size:Number = 34, skin:String = "button_bg", font:String = "Myriad"):Button
        {
            var button:Button = new Button(assetManager.assetManager.getTexture(skin));
            button.text  = label;
            button.fontName = font;
            button.fontColor = C_Color.MAIN_TEXT;
            button.fontSize = layout.relativeHeight(45, button.bounds);
            button.textHAlign = HAlign.LEFT;
            layout.proportionWidthScale(button, visViewPort, size);
            return button;
        }

        protected function setBackground(_background:String = ""):void
        {
            var headerBack:Quad = new Quad(layout.relativeWidth(100), layout.relativeHeight(HEADER_SIZE),C_Color.HEADER);
            layout.horizontalAlignCenter(headerBack);
            layout.verticalAlignTop(headerBack);

            var bottomColor:uint = C_Color.LIGHT_GREY;
            var topColor:uint    = C_Color.LIGHT_GREY_GRADIENT;

            headerBack.setVertexColor(0, C_Color.WHITE);
            headerBack.setVertexColor(1, C_Color.WHITE);
            headerBack.setVertexColor(2, topColor);
            headerBack.setVertexColor(3, bottomColor);

            //background = assetManager.getImage(_background);
            fitToScreenSize(headerBack);
            addChildAt(headerBack, 0)
        }

        public function fitToScreenSize(object:DisplayObject)
        {
            layout.proportionHeightScale(object, layout.visibleViewPort, 100);
            layout.verticalAlignTop(object, layout.viewPort);
            layout.horizontalAlignCenter(object, layout.viewPort);
        }

        public function drawBounds():void
        {
            var visView:Rectangle = layout.visibleViewPort;

            var fullbody:Quad = new Quad(visView.width, visView.height, C_Color.GREEN);
            layout.horizontalAlignCenter(fullbody);
            layout.verticalAlignTop(fullbody);
            addChild(fullbody);

            var subbody:Quad = new Quad(visView.width*.9, layout.visibleViewPort.height*.9, C_Color.GOLD);
            layout.horizontalAlignCenter(subbody);
            layout.verticalAlignMiddle(subbody);
            addChild(subbody);
        }


        public function systemMessage(message:String=""):void
        {
            var messageTF:TextField = new TextField(layout.relativeWidth(60), layout.relativeHeight(6), message, C_Font.Myriad, layout.relativeHeight(3));
                messageTF.alignPivot();
                messageTF.alpha =0;
                messageTF.color =C_Color.GREY;
                layout.horizontalAlignCenter(messageTF);
                layout.verticalAlignBottom(messageTF,null,30);
            addChild(messageTF);
            TweenMax.to(messageTF, 1.75, {alpha:.75, scaleX:1, scaleY:1, ease:Strong.easeOut, yoyo:true, onComplete:function():void{messageTF.removeFromParent(true)}})
        }


        public function setLoading(busy:Boolean=true):void
        {
            if (!busy && loadingCircle)
            {
                loadingCircle.removeFromParent();
                loadingCircle = null;
                return;
            }

            loadingCircle = new Sprite();
            loadingCircle.visible = 0;

            var modal:Quad = new Quad(layout.relativeWidth(100), layout.relativeHeight(100), C_Color.BLACK);
            modal.alpha = 0.35;
            layout.horizontalAlignCenter(modal);
            layout.verticalAlignMiddle(modal);
            loadingCircle.addChild(modal);

            var circle:Image = assetManager.getImage("loading_circle");
            circle.alignPivot();

            loadingCircle.addChild(circle);
            layout.proportionWidthScale(circle,null,10);
            layout.horizontalAlignCenter(circle);
            layout.verticalAlignMiddle(circle);

            TweenMax.to(circle, 2,{repeat:-1, rotation:160, yoyo:true,  ease:Strong.easeOut});

            this.addChild(loadingCircle);


            loadingCircle.visible = busy;
            if (busy)
            {
                TweenMax.from(loadingCircle,2.4, {alpha:0, delay:1});
            }
            else
            {
                TweenMax.to(loadingCircle, .1,{alpha:0, onComplete:function():void{loadingCircle.removeFromParent(true)}})
                this.removeChild(loadingCircle);
            }
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
    }
}
