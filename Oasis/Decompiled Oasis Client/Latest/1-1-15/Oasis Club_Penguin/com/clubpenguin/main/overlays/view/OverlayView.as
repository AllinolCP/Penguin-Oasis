package com.clubpenguin.main.overlays.view
{
    import flash.display.*;
    import org.osflash.signals.*;

    public class OverlayView extends Sprite
    {
        public var closeClickedSignal:Signal;
        public var closeButton:SimpleButton;
        private var modalBackground:Sprite;
        private static const MODAL_COLOR:Number = 0;
        private static const MODAL_ALPHA:Number = 0.5;

        public function OverlayView(param1:DisplayObject)
        {
            modalBackground = new Sprite();
            closeClickedSignal = new Signal();
            drawModal();
            this.addChild(modalBackground);
            this.addChild(param1);
            return;
        }// end function

        public function displayAsset() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function drawModal() : void
        {
            modalBackground.graphics.beginFill(MODAL_COLOR, MODAL_ALPHA);
            modalBackground.graphics.drawRect(0, 0, 760, 480);
            modalBackground.graphics.endFill();
            return;
        }// end function

    }
}
