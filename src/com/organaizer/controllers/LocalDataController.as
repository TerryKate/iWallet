package com.organaizer.controllers
{
    import com.organaizer.data.WalletData;
    import flash.events.NetStatusEvent;
    import flash.net.SharedObject;
    import flash.net.SharedObjectFlushStatus;

    public class LocalDataController extends BaseController
    {
        private var sharedObject:SharedObject;


        public function LocalDataController()
        {
            super();

            this.sharedObject = SharedObject.getLocal("AMPhoto");
        }


        public function getValue(key:String):String
        {
            return this.sharedObject.data[key] as String;
        }


        public function saveValue(key:String, value:String):void
        {

            this.sharedObject.data[key] = value;

            var flushStatus:String = null;

            try
            {
                flushStatus = this.sharedObject.flush(10000);
            }
            catch (error:Error)
            {
                trace("Error...Could not write SharedObject to disk\n");
            }
            if (flushStatus != null)
            {
                switch (flushStatus)
                {
                    case SharedObjectFlushStatus.PENDING:
                        trace("Requesting permission to save object...\n");
                        this.sharedObject.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
                        break;
                    case SharedObjectFlushStatus.FLUSHED:
                        trace("Value flushed to disk.\n");
                        break;
                }
            }
            trace("\n");
        }




        public function clearValue(key:String, addCharId:Boolean = false):void
        {
            trace("Cleared saved value...Reload SWF and the value should be \"undefined\".\n\n");
            delete this.sharedObject.data[key];
        }



        private function onFlushStatus(event:NetStatusEvent):void
        {
            trace("User closed permission dialog...\n");
            switch (event.info.code)
            {
                case "SharedObject.Flush.Success":
                    trace("User granted permission -- value saved.\n");
                    break;
                case "SharedObject.Flush.Failed":
                    trace("User denied permission -- value not saved.\n");
                    break;
            }
            trace("\n");

            this.sharedObject.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
        }


        public function getData():Object {
            return this.sharedObject.data.walletdata;
        }

        public function saveData(value:WalletData):void
        {
            this.sharedObject.data.walletdata = value;

            var flushStatus:String = null;

            try
            {
                flushStatus = this.sharedObject.flush(10000);
            }
            catch (error:Error)
            {
                trace("Error...Could not write SharedObject to disk\n");
            }
            if (flushStatus != null)
            {
                switch (flushStatus)
                {
                    case SharedObjectFlushStatus.PENDING:
                        trace("Requesting permission to save object...\n");
                        this.sharedObject.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
                        break;
                    case SharedObjectFlushStatus.FLUSHED:
                        trace("Value flushed to disk.\n");
                        break;
                }
            }
            trace("\n");
        }
    }
}