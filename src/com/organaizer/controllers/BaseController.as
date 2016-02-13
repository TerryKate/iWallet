package com.organaizer.controllers
{
    import starling.events.EventDispatcher;


    public class BaseController extends EventDispatcher
    {
        [Dispatcher] public var dispatcher:EventDispatcher;

        [Inject] public var layout:LayoutController;
        [Inject] public var assetController:AssetsController;
        [Inject] public var factory:InterfaceFactory;
        [Inject] public var localDataController:LocalDataController;


        public function randomRange(minNum:Number, maxNum:Number):Number
        {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }
    }
}
