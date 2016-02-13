package com.organaizer.mediators
{
    import com.organaizer.events.WalletEvent;
    import com.organaizer.views.WalletView;
    import com.creativebottle.starlingmvc.events.EventMap;


    public class WalletMediator extends BaseMediator
    {
        private var view:WalletView;
        private var eventMap:EventMap;

        [PostConstruct]
        public function AudaEvents():void
        {
            eventMap = new EventMap();
            eventMap.addMap(dispatcher, WalletEvent.WALLET_DATA_PLUS, onAddDataRequest);
            eventMap.addMap(dispatcher, WalletEvent.WALLET_DATA_BALANCE, onDataBalanceRequest);
            eventMap.addMap(dispatcher, WalletEvent.WALLET_DATA_CASH, onDataCashRequest);
            eventMap.addMap(dispatcher, WalletEvent.WALLET_DATA_SAVE, onSaveDataRequest);
        }

        private function onDataCashRequest(e:WalletEvent):void
        {

        }

        private function onDataBalanceRequest(e:WalletEvent):void
        {
        }

        private function onSaveDataRequest(e:WalletEvent):void
        {
              this.wallet.save();
        }

        private function onAddDataRequest(e:WalletEvent):void
        {

        }

        [ViewAdded]
        public function viewAdded(view:WalletView):void
        {
            this.view = view;
            this.view.create();
        }

        [ViewRemoved]
        public function viewRemoved(view:WalletView):void
        {
            view = null;
        }
    }
}
