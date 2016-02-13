/**
 * Created by Projects on 1.8.2015 г..
 */
package organaizer
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.Sprite;
import flash.net.URLRequest;

public class Assets
    {
        protected static const ASSETS:String = "Assets.swf";//"/../../assets/Assets.swf";

        public var\ assetLoader:Loader = new Loader();
        public var loadingCompletedListener:Function = null;

        public function Assets()
        {
            assetLoader = new Loader();
        }

        public function loadAsset(listener:Function):void
        {
            this.loadingCompletedListener = listener;
            this.assetLoader.load(new URLRequest(ASSETS));
        }


        public function createBitmap(bmpClassName:String):Bitmap
        {
            var bmpClass:Class = getClassDefinition(bmpClassName);

            if (bmpClass)
            {
                var bmpData:BitmapData = new bmpClass(0, 0) as BitmapData;
                return new Bitmap(bmpData);
            }

            return null;
        }

        public function getSprite(bmpClassName:String):Sprite
        {
            var spriteClass:Class = getClassDefinition(bmpClassName);

            if(spriteClass)return spriteClass as Sprite;

            return null;
        }

        public function getClassDefinition(definition:String):Class
        {
            if (assetLoader.contentLoaderInfo.applicationDomain.hasDefinition(definition))
            {
                return assetLoader.contentLoaderInfo.applicationDomain.getDefinition(definition) as Class;
            }
            return null;
        }
    }
}
