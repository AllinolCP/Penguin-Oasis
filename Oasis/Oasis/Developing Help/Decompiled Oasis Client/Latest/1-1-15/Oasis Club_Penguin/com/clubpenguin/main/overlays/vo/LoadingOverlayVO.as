package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.main.overlays.type.*;
    import flash.display.*;

    public class LoadingOverlayVO extends OverlayVO
    {
        public static const LOADING_OVERLAY_ID:String = "loadingOverlayID";

        public function LoadingOverlayVO(param1:DisplayObject)
        {
            this.object = param1;
            this.id = LOADING_OVERLAY_ID;
            this.type = OverlayType.DISPLAY;
            return;
        }// end function

    }
}
