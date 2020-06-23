package com.clubpenguin.main.overlays.vo
{
    import com.clubpenguin.main.overlays.type.*;
    import flash.display.*;

    public class OverlayVO extends Object
    {
        public var type:OverlayType;
        public var standalone:Boolean;
        public var dataObject:Object;
        public var modal:Boolean;
        public var url:String;
        public var id:String;
        public var object:DisplayObject;

        public function OverlayVO()
        {
            return;
        }// end function

    }
}
