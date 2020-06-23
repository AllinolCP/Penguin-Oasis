package com.clubpenguin.main.modules
{

    public class ModuleFilenamesEnum extends Object
    {
        private var _key:String;
        private var _filename:String;
        public static const UGC_WALL:ModuleFilenamesEnum = new ModuleFilenamesEnum("ugc_wall", "ugc_wall.swf");
        public static const NEWSPAPER:ModuleFilenamesEnum = new ModuleFilenamesEnum("current_AS3_news", "newspaper.swf");
        public static const FILENAMES:Array = [NEWSPAPER, UGC_WALL];

        public function ModuleFilenamesEnum(param1:String, param2:String)
        {
            this._key = param1;
            this._filename = param2;
            return;
        }// end function

        public function get filename() : String
        {
            return _filename;
        }// end function

        public function get key() : String
        {
            return this._key;
        }// end function

        public static function getFilename(param1:String) : String
        {
            var _loc_2:int = 0;
            while (_loc_2 < FILENAMES.length)
            {
                
                if (ModuleFilenamesEnum.ModuleFilenamesEnum(FILENAMES[_loc_2]).key == param1)
                {
                    return ModuleFilenamesEnum.ModuleFilenamesEnum(FILENAMES[_loc_2]).filename;
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

    }
}
