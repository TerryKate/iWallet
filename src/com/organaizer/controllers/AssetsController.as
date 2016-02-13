package com.organaizer.controllers
{
    import starling.display.Image;
    import starling.textures.Texture;
    import starling.utils.AssetManager;

    public class AssetsController extends BaseController
    {
        public var assetManager:AssetManager;

        [EventHandler(event="SET_ASSETS_MANAGER", properties="assetManager")]
        public function setAssetsManager(assetManager:AssetManager):void
        {
            this.assetManager = assetManager;
        }

        public function getImage(textureId:String):Image
        {
            var texture:Texture;
            if (assetManager.getTexture(textureId) != null)
                texture = assetManager.getTexture(textureId);
            return new Image(texture);
        }

        public function getTexture(textureId:String):Texture
        {
            var texture:Texture;
            if (assetManager.getTexture(textureId) != null)
                texture = assetManager.getTexture(textureId);
            return texture;
        }
    }
}
