package com.clubpenguin.managers.vo
{

    public class AssetVO extends Object
    {
        private var _datapath:String;
        private var _url:String;
        private var _object:Object;

        public function AssetVO()
        {
            return;
        }// end function

        public function set object(param1) : void
        {
            _object = param1;
            return;
        }// end function

        public function get url() : String
        {
            return _url;
        }// end function

        public function set url(param1:String) : void
        {
            _url = param1;
            return;
        }// end function

        public function get datapath() : String
        {
            return _datapath;
        }// end function

        public function set datapath(param1:String) : void
        {
            _datapath = param1;
            return;
        }// end function

        public function get object()
        {
            return _object;
        }// end function

    }
}
