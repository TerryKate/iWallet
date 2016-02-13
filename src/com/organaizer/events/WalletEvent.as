package com.organaizer.events
{
    import starling.events.Event;

    public class WalletEvent extends Event
    {
        public static const WALLET_DATA_BALANCE:String = "WALLET_DATA_BALANCE";
        public static const WALLET_DATA_CASH:String = "WALLET_DATA_CASH";
        public static const WALLET_DATA_PLUS:String = "WALLET_DATA_PLUS";
        public static const WALLET_DATA_SAVE:String = "WALLET_DATA_SAVE";

        public function WalletEvent(type:String, bubbles:Boolean=false, params:Object = null)
        {
            super(type, bubbles, data);

            switch (type)
            {
                case WALLET_DATA_SAVE:

                    break;
            }
        }

    }
}
