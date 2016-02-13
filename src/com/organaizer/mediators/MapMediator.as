package com.organaizer.mediators
{
    import com.creativebottle.starlingmvc.events.EventMap;
    import com.organaizer.views.Map;

    public class MapMediator extends BaseMediator
    {
        private var view:Map;
        private var eventMap:EventMap;

        [PostConstruct]
        public function AudaEvents():void
        {
            eventMap = new EventMap();
           // eventMap.addMap(dispatcher, CommEvent.SELECT_SERVER, onServerSelect);
        }


        [ViewAdded]
        public function viewAdded(view:Map):void
        {
            this.view = view;
            this.view.create();
            this.view.setDataProvider(wallet.getBalanceData());
            this.addEvents();
        }

        private function addEvents():void
        {
            //eventMap.addMap(dispatcher, CommEvent.IDENT_REQUEST, onLoginRequest);
        }


        [ViewRemoved]
        public function viewRemoved(view:Map):void
        {
            view = null;
        }
    }
}
