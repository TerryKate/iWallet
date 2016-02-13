package
{
    import com.organaizer.beanFactory;

    import flash.display.Sprite;
    import flash.events.UncaughtErrorEvent;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.AssetManager;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;

    [SWF(width="100%", height="100%", frameRate="60", backgroundColor="#252a31")]
    public class init extends Sprite
    {
        private var mStarling:Starling;

        public function init()
        {
            var stageWidth:int  = 480;
            var stageHeight:int = 320;
            var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);

            Starling.multitouchEnabled = true;
            Starling.handleLostContext = !iOS;

            var viewPort:Rectangle = RectangleUtil.fit(
                    new Rectangle(0, 0, stageWidth, stageHeight),
                    new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
                    ScaleMode.NO_BORDER, iOS);

            var scaleFactor:int = viewPort.width < 480 ? 1 : 2;
            var appDir:File = File.applicationDirectory;

            var assets:AssetManager = new AssetManager(scaleFactor);
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(
                    appDir.resolvePath("ui")
            );

            Starling.handleLostContext = true;
            mStarling = new Starling(beanFactory, stage, viewPort, null, "auto");
            mStarling.stage.alpha = 0.999;
            mStarling.showStats = true;

            mStarling.stage.stageWidth  = stageWidth;
            mStarling.stage.stageHeight = stageHeight;

            mStarling.simulateMultitouch  = false;
            mStarling.enableErrorChecking = true;

            mStarling.addEventListener(Event.ROOT_CREATED, function(e:Event):void
            {
                var _init:beanFactory = mStarling.root as beanFactory;
                _init.load(assets);

                mStarling.start();
            });
        }

        private function uncaughtErrorHandler(event:UncaughtErrorEvent):void
        {
            trace("init detected uncaughtError!" + event)
        }
    }
}
