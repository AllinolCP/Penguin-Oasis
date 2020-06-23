package com.clubpenguin.main.overlays.type
{

    public class OverlayType extends Object
    {
        private var ordinal:uint;
        private var value:String;
        public static const DISPLAY:OverlayType = new OverlayType("Display", 2);
        public static const MODULE:OverlayType = new OverlayType("Module", 1);

        public function OverlayType(param1:String, param2:uint)
        {
            this.value = param1;
            this.ordinal = param2;
            return;
        }// end function

        public static function selectByValue(param1:String) : OverlayType
        {
            var _loc_2:OverlayType = null;
            for each (_loc_2 in OverlayType.list)
            {
                
                if (param1 == _loc_2.value)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public static function get list() : Array
        {
            return [MODULE, DISPLAY];
        }// end function

    }
}
