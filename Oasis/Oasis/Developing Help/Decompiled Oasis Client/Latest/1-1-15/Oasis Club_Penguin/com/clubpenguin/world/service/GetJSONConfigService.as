package com.clubpenguin.world.service
{
    import com.clubpenguin.world.service.http.*;

    public class GetJSONConfigService extends HTTPServiceRequest
    {
        private static const GET_JSON_CONFIG_URL:String = "../local_config/flashvars.json";

        public function GetJSONConfigService()
        {
            setURL(GET_JSON_CONFIG_URL, HTTPServiceRequest.JSON_ENCODING);
            return;
        }// end function

    }
}
