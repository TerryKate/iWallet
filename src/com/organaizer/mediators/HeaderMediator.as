package com.organaizer.mediators
{
import com.organaizer.events.WalletEvent;
import com.organaizer.views.Header;

    import com.creativebottle.starlingmvc.events.EventMap;

import organaizer.Wallet;

import starling.display.Button;
import starling.events.Event;

public class HeaderMediator extends BaseMediator
    {
        private var view:Header;
        private var eventMap:EventMap;

        [PostConstruct]
        public function AudaEvents():void
        {
            eventMap = new EventMap();
           // eventMap.addMap(dispatcher, CommEvent.SELECT_SERVER, onServerSelect);
        }


        [ViewAdded]
        public function viewAdded(view:Header):void
        {
            this.view = view;
            this.view.create();
            //this.view.setDataProvider();
            this.addEvents();
        }

        private function addEvents():void
        {
            //eventMap.addMap(dispatcher, CommEvent.IDENT_REQUEST, onLoginRequest);
            view.headerBtn.addEventListener(Event.TRIGGERED, onHeaderRequest);
        }

        private function onHeaderRequest(event:Event):void
        {
            dispatcher.dispatchEvent(new WalletEvent(WalletEvent.WALLET_DATA_CASH));
        }


        [ViewRemoved]
        public function viewRemoved(view:Header):void
        {
            view = null;
        }
    }
}
