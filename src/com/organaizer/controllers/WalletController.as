/**
 * Created by Projects on 13.10.2015 г..
 */
package com.organaizer.controllers
{
    import com.organaizer.constants.C_Local;
    import com.organaizer.data.WalletData;
    import com.organaizer.models.WalletItem;

    import feathers.data.ListCollection;

    public class WalletController extends BaseController
    {
        private var _data:WalletData = new WalletData();

        [Inject] public var local:LocalDataController;

        [PostConstruct] public function WalletControlls():void
        {
            if(!local.getValue(C_Local.iWALLET_ID)) {
                local.saveValue(C_Local.iWALLET_ID, "ID");
                _data.setDefaults();
                save();
            }
            else {
                _data.initFrom(local.getData());
            }
        }

        public function save():void {
            local.saveData(_data);  trace("saving data..");
        }

        public function get data():WalletData {
            return _data;
        }

        public function set data(value:WalletData):void {
            _data = value;
        }

        public function getBalanceData():ListCollection {
            var provider:ListCollection = new ListCollection();
            var _item:WalletItem;
            var i:Number;

            for(i=0; i<data.balanceItems.length; i++)
            {
                _item = new WalletItem();
                _item.initFrom(data.balanceItems[i]);
                provider.push(_item);
            }
            return provider;
        }
    }
}
