/**
 * Created by Auto on 28.3.2015 г..
 */
package com.organaizer.models
{

    public class WalletItem extends BaseModel
    {
        private static const na:String = "N/A";

        public var id:Number = 0;
        public var title:String = "sub";
        public var icon:String = "sub";
        public var value:Number = 0;

        public function WalletItem()
        {

        }

        public function initFrom(_object:Object):void
        {
            id        = _object['id'];
            icon      = _object['icon'];
            value      = _object['value'];
        }
    }
}
