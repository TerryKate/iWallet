package com.organaizer.provaiders
{
    import com.organaizer.mediators.CallendarMediator;
    import com.organaizer.mediators.HeaderMediator;
    import com.organaizer.mediators.MapMediator;
    import com.organaizer.mediators.WalletMediator;
    import com.creativebottle.starlingmvc.beans.BeanProvider;
    import com.organaizer.mediators.BaseMediator;

    public class Mediators extends BeanProvider
    {
        public function Mediators()
        {
            beans = [
                new BaseMediator(),
                new WalletMediator(),
                new HeaderMediator(),
                new MapMediator(),
                new CallendarMediator()
            ];
        }
    }
}	