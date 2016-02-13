package com.organaizer.mediators
{
    import com.organaizer.views.CallendarView;
    import com.creativebottle.starlingmvc.events.EventMap;


    public class CallendarMediator extends BaseMediator
    {
        private var view:CallendarView;
        private var eventMap:EventMap;

        [PostConstruct]
        public function AudaEvents():void
        {
            eventMap = new EventMap();
        }



        [ViewAdded]
        public function viewAdded(view:CallendarView):void
        {
            this.view = view;
            this.view.create();
        }

        [ViewRemoved]
        public function viewRemoved(view:CallendarView):void
        {
            view = null;
        }
    }
}
