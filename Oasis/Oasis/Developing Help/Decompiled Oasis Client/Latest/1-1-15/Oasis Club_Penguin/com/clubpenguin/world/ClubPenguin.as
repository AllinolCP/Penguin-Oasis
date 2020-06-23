package com.clubpenguin.world
{
    import flash.display.*;

    public class ClubPenguin extends MovieClip
    {
        private var gameWorldContext:WorldContext;

        public function ClubPenguin()
        {
            addFrameScript(0, frame1);
            init();
            return;
        }// end function

        private function init() : void
        {
            stage.scaleMode = StageScaleMode.SHOW_ALL;
            gameWorldContext = new WorldContext(this);
            return;
        }// end function

        function frame1()
        {
            return;
        }// end function

    }
}
