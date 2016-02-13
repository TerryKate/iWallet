/**
 * Created by Projects on 23.5.2015 г..
 */
package com.organaizer.mediators
{
    import com.organaizer.views.NavigationView;
    import com.creativebottle.starlingmvc.events.EventMap;

    public class NavigationMediator extends BaseMediator
        {

            private var view:NavigationView;
            private var eventMap:EventMap;

            public function NavigationMediator()
            {

            }


            [ViewAdded]
            public function viewAdded(view:NavigationView):void
            {
                 this.view = view;
                 this.view.create();
            }


            [ViewRemoved]
            public function viewRemoved(view:NavigationView):void
            {
                view = null;
            }
        }
}
