package organaizer
{

import flash.display.Sprite;
import flash.events.Event;
    import flash.text.TextField;

    import com.organaizer.ui.ArrowButton;
    import com.organaizer.ui.Button;

    public class Wallet  extends Interface
    {
        private var assetManager:Assets;
        private var layout:Layout;

        public function Wallet(_assetManager:Assets)
        {
            assetManager = _assetManager;
            addEventListener(Event.ENTER_FRAME, create);
        }


        public function create(e:Event):void
        {
            layout = new Layout(stage.stageWidth, stage.stageHeight);
            removeEventListener(Event.ENTER_FRAME, create);



            drawTest();
        }


        private function drawTest():void
        {
            var topSprite:Sprite = new Sprite();

            var arrowButton:ArrowButton = new ArrowButton(assetManager, ArrowButton.LEFT);
                arrowButton.y = layout.heightPercent(3);
                arrowButton.addEventListener(Button.TAP, onButtonTap);
            topSprite.addChild(arrowButton);


            var btm:Button = new Button(assetManager);
                btm.y = layout.heightPercent(3);
                btm.addEventListener(Button.TAP, onButtonTap);
                btm.x+=  btm.x + arrowButton.width;
            topSprite.addChild(btm);

            var arrowButtonR:ArrowButton = new ArrowButton(assetManager, ArrowButton.RIGHT);
                arrowButtonR.y = layout.heightPercent(3);
                arrowButtonR.addEventListener(Button.TAP, onButtonTap);
                arrowButtonR.x+=  btm.x + btm.width;
            topSprite.addChild(arrowButtonR);


            addChild(topSprite);

            topSprite.x = layout.widthPercent(50) - topSprite.width*.5;


            var leftPane:TextField = newTextField("LeftPane");
                leftPane.y = layout.heightPercent(10);
                leftPane.width = layout.widthPercent(50);
                //leftPane.border = true;
            addChild(leftPane)

            var rightPane:TextField = newTextField("RightPane");
                rightPane.x = layout.widthPercent(50);
                rightPane.y = layout.heightPercent(10);
                rightPane.width = layout.widthPercent(50);
                //rightPane.border = true;
            addChild(rightPane);
        }

        private function onButtonTap(event:Event):void {
                        trace("TAP")
        }
    }
}
