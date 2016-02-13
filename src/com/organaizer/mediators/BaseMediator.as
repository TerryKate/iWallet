package com.organaizer.mediators
{
    import com.organaizer.controllers.WalletController;
    import starling.events.EventDispatcher;

    public class BaseMediator
    {
        [Dispatcher] public var dispatcher:EventDispatcher;

        [Inject] public var wallet:WalletController;
    }
}
