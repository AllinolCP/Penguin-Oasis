package com.clubpenguin.world.model
{
    import flash.system.*;

    public class EnvironmentData extends Object
    {
        public var contentPath:String = "content/";
        public var gamesPath:String = "games/";
        public var affiliateID:Number = 1;
        public var isRunningLocally:Boolean = false;
        public var clientPath:String = "client/";
        public var language:String = "";
        public var connectionID:String = "testConnectionID";
        public var fieldOp:String = "";
        public var basePath:String = "";
        public var promotionID:Number = 1;

        public function EnvironmentData()
        {
            if (Capabilities.playerType != "External")
            {
            }
            isRunningLocally = Capabilities.playerType == "StandAlone";
            return;
        }// end function

        public function fromObject(param1:Object) : void
        {
            language = param1.lang;
            affiliateID = param1.a;
            promotionID = param1.p;
            fieldOp = param1.field_op;
            basePath = param1.base ? (param1.base) : (basePath);
            clientPath = param1.client;
            contentPath = param1.content;
            gamesPath = param1.games;
            connectionID = param1.connectionID ? (param1.connectionID) : (connectionID);
            return;
        }// end function

    }
}
