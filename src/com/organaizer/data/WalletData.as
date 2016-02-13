package com.organaizer.data
{
    import com.organaizer.models.WalletItem;

    public class WalletData
    {
        private var _balance:Number = 0.0;
        private var _balanceItems:Array = [];

        public function initFrom(_data:Object):void {
            _balance = _data['balance'];
            _balanceItems = _data['balanceItems'];
        }

        public function setDefaults():void {
            trace("[WalletData] Setting defaults*");
            balance = 0;
            var wallet:WalletItem = new WalletItem();
                wallet.id = 0;
                wallet.title = "CASH";
                wallet.value = 0.00;
            balanceItems.push(wallet);
        }

        public function get balance()       :Number {   return _balance;        }
        public function get balanceItems()  :Array  {   return _balanceItems;   }


        public function set balance(value:Number):void {
            _balance = value;
        }


        public function set balanceItems(value:Array):void {
            _balanceItems = value;

        }


    }
}
