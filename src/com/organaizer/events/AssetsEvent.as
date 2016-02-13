package com.organaizer.events
{
import starling.events.Event;
import starling.utils.AssetManager;

public class AssetsEvent extends Event
{
    public static const SET_ASSETS_MANAGER:String = "SET_ASSETS_MANAGER";
    public static const LOAD_ASSET:String = "LOAD_ASSET";
    public static const LOAD_ASSET_DONE:String = "UNLOAD_ASSET_DONE";
    public static const UNLOAD_ASSET_DONE:String = "LOAD_ASSET_DONE";

    private var _assetManager:AssetManager;

    public function AssetsEvent(type:String, bubbles:Boolean=false, params:Array = null)
    {
        super(type, bubbles, data);

        switch (type)
        {
            case LOAD_ASSET:
                //_assetPath = params[0];
                //_assetContainer = params[1];
                //_assetType = params[2];
                break;

            case LOAD_ASSET_DONE:
                //_assetPath = params[0];
                //_assetContainer = params[1];
                break;

            case SET_ASSETS_MANAGER:
                _assetManager = params[0];
                break;
        }
    }

    public function get assetManager():AssetManager
    {
        return _assetManager;
    }

}
}
