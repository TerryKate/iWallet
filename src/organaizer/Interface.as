package organaizer
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;


    public class Interface extends Sprite
    {

        public function newLabel( _str:String = "_nostring_", _size:Number=22, _font:String="Roboto" ):TextField
        {
            var format:TextFormat = new TextFormat();
                format.color = 0x999FA0;
                format.font = _font;
                format.size = _size;
                format.align = TextFormatAlign.CENTER;

            var _tf:TextField = new TextField();
                _tf.defaultTextFormat = format;
                _tf.embedFonts = true;
                _tf.text = _str;
                _tf.selectable = false;
            return _tf;
        }

        public function newTextField( _str:String = "_nostring_", _size:Number=20, _font:String="Comfortaa" ):TextField
        {
            var _tf:TextField = new TextField();
                _tf.defaultTextFormat = new TextFormat(_font, _size);
                _tf.embedFonts = true;
                _tf.text = _str;
                //_tf.wordWrap = true;
                _tf.type = TextFieldType.INPUT;
            return _tf;
        }

        private function centralizeV(TT:TextField) {
            var TL:Number;
            if (TT.numLines > 1) TL = TT.textHeight / (TT.numLines - 1)
            else TL = TT.textHeight;
            var deltaL:int = int((TT.height - TT.textHeight) / 2 / TL);
            for (var k:int = 0; k < deltaL; k++) {
                TT.text = "\n" + TT.text;
            }
        }

        [Embed
                (
                source="/../assets/fonts/RobotoCondensed-Regular.ttf",
                fontName = "Roboto",
                mimeType = "application/x-font",
                advancedAntiAliasing="true",
                embedAsCFF="false"
                )]
        private var _fontRoboto:Class;

        [Embed
                (
                source="/../assets/fonts/Comfortaa-Regular.ttf",
                fontName = "Comfortaa",
                mimeType = "application/x-font",
                advancedAntiAliasing="true",
                embedAsCFF="false"
                )]
        private var _fontComfortaa:Class;
    }
}
