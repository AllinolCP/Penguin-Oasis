package com.clubpenguin.main.dialogboxes
{
    import flash.display.*;
    import flash.text.*;

    dynamic public class LoadingDialog extends MovieClip
    {
        public var textBox:TextField;

        public function LoadingDialog()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

    }
}
