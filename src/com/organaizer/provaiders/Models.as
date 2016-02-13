package com.organaizer.provaiders
{
    import com.creativebottle.starlingmvc.beans.BeanProvider;

    import com.organaizer.models.Attachment;
    import com.organaizer.models.BaseModel;
    import com.organaizer.models.WalletItem;

    public class Models extends BeanProvider
    {
        public function Models()
        {
            beans = [
                new BaseModel(),
                new Attachment(),
                new WalletItem()
            ];
        }
    }
}	