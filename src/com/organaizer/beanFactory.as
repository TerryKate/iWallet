package com.organaizer
{
    import com.organaizer.constants.C_Color;
    import com.organaizer.provaiders.Controllers;
    import com.organaizer.provaiders.Mediators;
    import com.organaizer.provaiders.Models;
    import com.organaizer.events.AssetsEvent;
    import com.organaizer.events.NavigationEvent;
    import com.organaizer.views.WalletView;

    import com.creativebottle.starlingmvc.StarlingMVC;
    import com.creativebottle.starlingmvc.beans.Bean;
    import com.creativebottle.starlingmvc.config.StarlingMVCConfig;
    import com.creativebottle.starlingmvc.views.ViewManager;

    import starling.core.Starling;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.EventDispatcher;
    import starling.text.TextField;
    import starling.utils.AssetManager;
    import starling.utils.HAlign;


    public class beanFactory extends Sprite
    {
        [Dispatcher] public var dispatcher:EventDispatcher;
        private var starlingMVC:StarlingMVC;

        public function beanFactory():void
        {
            var beans:Array;
            var config:StarlingMVCConfig = new StarlingMVCConfig();

            config.eventPackages = ["com.organaizer.events"];
            config.viewPackages =  ["com.organaizer.views", "com.organaizer.ui", "com.organaizer.miniviews"];

            beans = [
                new Models(),
                new Mediators(),
                new Controllers(),
                new Bean(new ViewManager(this))
            ];

            starlingMVC = new StarlingMVC(this, config, beans);
        }

        public function load(assets:AssetManager):void
        {
            var loadingQuad:Quad = new Quad(1, 3, C_Color.BATTERY_GREEN);
            loadingQuad.alignPivot();

            loadingQuad.x = stage.stageWidth/2;
            loadingQuad.y = stage.stageHeight/2;
            addChild(loadingQuad);

            var loadingTF:TextField = new TextField(stage.stageWidth*.2,20,"");
            loadingTF.fontSize = loadingTF.height*.25;
            loadingTF.color = C_Color.WHITE;
            // loadingTF.border = true;
            addChild(loadingTF);

            dispatchEvent(new AssetsEvent(AssetsEvent.SET_ASSETS_MANAGER, true, [assets]));
            assets.loadQueue(function (ratio:Number):void
            {
                loadingQuad.width = (ratio * 100);

                loadingTF.hAlign = HAlign.RIGHT;
                loadingTF.x = loadingQuad.x - loadingTF.width + loadingQuad.width*.5;
                loadingTF.y = loadingQuad.y - loadingQuad.height;
                loadingTF.text = trim((ratio * 100),2)+"%";

                Starling.current.showStats = false;

                if (ratio == 1)
                {
                    loadingQuad.removeFromParent(true);
                    loadingTF.removeFromParent(true);

                    onAssetsLoaded();
                }
            });
        }

        public function trim(theNumber:Number, decPlaces:Number) : Number {
            if (decPlaces >= 0) {
                var temp:Number = Math.pow(10, decPlaces);
                return Math.round(theNumber * temp) / temp;
            }

            return theNumber;
        }
        private function onAssetsLoaded():void
        {
            dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.ADD_VIEW, true, WalletView));
        }
    }
}
