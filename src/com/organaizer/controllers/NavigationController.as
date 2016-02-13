package com.organaizer.controllers
{
    import com.creativebottle.starlingmvc.events.EventMap;
    import com.creativebottle.starlingmvc.views.ViewManager;
    import com.organaizer.events.NavigationEvent;

    import starling.display.Sprite;
    import starling.events.EventDispatcher;


    public class NavigationController extends EventDispatcher
    {
        [Dispatcher] public var dispatcher:EventDispatcher;

        [Inject]  public var viewManager:ViewManager;

        public var currentView:Class;
        private var eventMap:EventMap;

        [PostConstruct]
        public function NavigationEvents():void
        {
            eventMap = new EventMap();
            eventMap.addMap(dispatcher, NavigationEvent.ADD_VIEW, addView);
            eventMap.addMap(dispatcher, NavigationEvent.NAVIGATE_TO_VIEW, navigateToView);
        }

        public function addView(e:NavigationEvent):void
        {
            var viewClass:Class = e.viewClass;
            if (!viewManager)
            {
                viewManager = new ViewManager(viewClass as Sprite);
            }

            viewManager.setView(viewClass);

        }

        public function navigateToView(e:NavigationEvent):void
        {
            var viewClass:Class = e.viewClass;
            //viewManager.
            viewManager.setView(viewClass);
        }
    }
}
