package com.organaizer.controllers
{
    import com.organaizer.constants.C_Color;

    import feathers.controls.Button;
    import feathers.controls.ScrollBar;
    import feathers.controls.TextInput;
    import feathers.controls.text.StageTextTextEditor;
    import feathers.core.ITextEditor;
    import feathers.display.Scale3Image;
    import feathers.textures.Scale3Textures;

    import flash.geom.Rectangle;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.events.Event;
import starling.filters.BlurFilter;
import starling.textures.Texture;

public class InterfaceFactory extends BaseController
{

    [Inject] public var assetsController:AssetsController;

    [PostConstruct] public function PostControls():void {}

    public function getTextInput(propmpt:String="", isPass:Boolean=false, relWidth:Number=45, relHeight:Number=6):TextInput
    {
        var _width  = layout.relativeWidth(relWidth);
        var _height = layout.relativeHeight(relHeight);

        var input:TextInput = new TextInput();
        input.width = _width;
        input.height = _height;
        input.text = propmpt;

        input.paddingTop = 5;
        input.paddingLeft = 2;
        input.maxChars = 16;
        input.restrict = "a-z0-9_A-Z.";
        input.displayAsPassword = isPass;
        var inputBackground:Quad = new Quad(input.width*1.3,input.height*1.2,C_Color.WHITE);
        //inputBackground.setVertexColor(0, C_Color.WHITE);
        //inputBackground.setVertexColor(1, C_Color.LIGHT_GREY_GRADIENT);
        //inputBackground.setVertexColor(2, C_Color.LIGHT_GREY_GRADIENT);
        //inputBackground.setVertexColor(3, C_Color.WHITE);
        //inputBackground.alpha=.9;
        // input.backgroundSkin = inputBackground;

        input.textEditorFactory = function():ITextEditor
        {
            var editor:StageTextTextEditor = new StageTextTextEditor();
            editor.fontFamily = "Arial";
            editor.fontSize = _height*.5;
            //editor.textAlign = TextAlign.CENTER;
            editor.color = C_Color.GREY;
            return editor;
        };
        //input.selectRange( 0, input.text.length );

        return input;
    }

    public function simpleScrollBarFactory():ScrollBar
    {
        var texThumb:Texture = assetsController.assetManager.getTexture("scrollbarHandleBlue");//assetsController.getImage("scrollbarHandleBlue").texture;
        var texTrack:Texture = assetsController.assetManager.getTexture("scrollBarShadow");//assetsController.getImage("scrollBarShadow").texture;

        var sectionsSize:Number = int(texThumb.height/3);
        var scale3TexturesThumb:Scale3Textures = new Scale3Textures(texThumb, sectionsSize, sectionsSize, Scale3Textures.DIRECTION_VERTICAL);
        var scale3TexturesTrack:Scale3Textures = new Scale3Textures(texTrack, sectionsSize, texTrack.height - sectionsSize*2, Scale3Textures.DIRECTION_VERTICAL);

        var scrollBar:ScrollBar = new ScrollBar();

        scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
        scrollBar.width = texThumb.width;
        scrollBar.height = sectionsSize;
        scrollBar.thumbProperties.defaultSkin           = new Scale3Image( scale3TexturesThumb );
        scrollBar.minimumTrackProperties.defaultSkin    = new Scale3Image( scale3TexturesTrack );
        scrollBar.x += layout.relativeWidth(5);

        return scrollBar;
    }


    public function getDefaultButton(label:String="",relHeight:Number=8, texture:String="", rect:Rectangle=null):Button
    {
        if (!rect)
        {
            rect = layout.visibleViewPort;
        }
        var skin:Image = assetsController.getImage(texture);
        layout.proportionHeightScale(skin, rect, relHeight);
        //var downSkin:Image = assetsController.getImage("1back_button");
        //downSkin.color = C_Color.AUDA;


        var button:Button = new Button();
        button.defaultSkin = skin;
        //button.downSkin = downSkin;



        button.addEventListener(Event.TRIGGERED, function():void
        {
            skin.color = C_Color.AUDA;
            layout.setFilter(button)
            trace("button pressed")
        })
        return button;
    }

    public function getBrLine():Quad
    {
        var _q:Quad = new Quad(layout.relativeWidth(100), .5, C_Color.BATTERY_LIGHT);
        //var _f:BlurFilter = BlurFilter.createGlow(C_Color.BATTERY_GREY, 2.5, .65, .45);

        //    layout.setFilter(_q, true, _f);
        return _q;
    }
}

}
