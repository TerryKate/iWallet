/**
 * Created by Projects on 13.10.2015 г..
 */
package com.organaizer.data
{
    public class DataBalance extends DataObject
    {
        private var _currentCash:Number = 100.25;

        public function get currentCash():Number {
            return _currentCash;
        }

        public function set currentCash(value:Number):void {
            _currentCash = value;
        }
    }
}
