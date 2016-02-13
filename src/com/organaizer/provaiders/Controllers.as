package com.organaizer.provaiders
{
    import com.organaizer.controllers.InterfaceFactory;
    import com.organaizer.controllers.LocalDataController;
    import com.creativebottle.starlingmvc.beans.BeanProvider;

    import com.organaizer.controllers.AssetsController;
    import com.organaizer.controllers.BaseController;
    import com.organaizer.controllers.LayoutController;
    import com.organaizer.controllers.NavigationController;
import com.organaizer.controllers.WalletController;

public class Controllers extends BeanProvider
    {
        public function Controllers()
        {
            beans = [
                new BaseController(),
                new AssetsController(),
                new NavigationController(),
                new LayoutController(),
                new LocalDataController(),
                new InterfaceFactory(),
                new WalletController()

                //new SoapController()
            ];
        }
    }
}	