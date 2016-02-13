/**
 * Created by Projects on 1.8.2015 г..
 */
package organaizer
{
    import flash.geom.Rectangle;

import com.organaizer.ui.Button;

public class Layout
    {
        private var _viewPort:Rectangle;

        public function Layout(_width:Number, _height:Number){
             viewPort = new Rectangle(0,0,_width,_height)
        }

        public function get viewPort():Rectangle{
            return _viewPort;
        }

        public function set viewPort(value:Rectangle):void {
            _viewPort = value;
        }

        public function get width():Number {
            return _viewPort.width;
        }

        public function get height():Number {
            return _viewPort.height;
        }

        public function horizontalCenter():Number {
            return _viewPort.width*.5;
        }

        public function widthPercent(i:int):Number {
            return _viewPort.width*i / 100;
        }

        public function heightPercent(i:int):Number {
            return _viewPort.height*i / 100;
        }


        public function snapUnder(btm:Button, i:int=0):Number {
               return btm.y + btm.height + i;
        }
    }
}
