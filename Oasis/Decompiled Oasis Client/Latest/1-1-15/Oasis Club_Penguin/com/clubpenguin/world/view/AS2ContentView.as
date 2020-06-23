package com.clubpenguin.world.view
{
    import flash.display.*;

    public class AS2ContentView extends MovieClip
    {
        private var _as2Content:Loader;

        public function AS2ContentView()
        {
            return;
        }// end function

        public function addContent(param1:Loader) : void
        {
            _as2Content = param1;
            addChild(_as2Content);
            return;
        }// end function

    }
}
