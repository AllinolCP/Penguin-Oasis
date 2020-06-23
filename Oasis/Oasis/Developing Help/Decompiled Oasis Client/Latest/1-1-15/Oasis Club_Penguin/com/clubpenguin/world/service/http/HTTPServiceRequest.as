package com.clubpenguin.world.service.http
{
    import com.adobe.serialization.json.*;
    import flash.events.*;
    import flash.net.*;
    import org.osflash.signals.*;
    import org.robotlegs.mvcs.*;

    public class HTTPServiceRequest extends Actor
    {
        public var response:HTTPResponse;
        public var responseReceived:Signal;
        public var requestFailed:Signal;
        private var _url:String;
        private var _loader:URLLoader;
        private var _responseEncoding:String;
        private var _request:URLRequest;
        public static const TEXT_ENCODING:String = "text";
        public static const JSON_ENCODING:String = "json";
        public static const XML_ENCODING:String = "xml";

        public function HTTPServiceRequest()
        {
            responseReceived = new Signal(HTTPResponse);
            requestFailed = new Signal(HTTPResponse);
            return;
        }// end function

        public function onIOError(event:IOErrorEvent) : void
        {
            response.errorMessage = event.text;
            requestFailed.dispatch(response);
            return;
        }// end function

        public function send() : void
        {
            if (!_url)
            {
                throw new Error("HTTPServiceRequest.send called when url not set.");
            }
            _request = new URLRequest(_url);
            _loader = new URLLoader();
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _loader.addEventListener(Event.COMPLETE, onComplete);
            response = new HTTPResponse();
            _loader.load(_request);
            return;
        }// end function

        protected function setURL(param1:String, param2:String) : void
        {
            _url = param1;
            if (param2)
            {
                _responseEncoding = param2;
            }
            else
            {
                _responseEncoding = TEXT_ENCODING;
            }
            return;
        }// end function

        public function onSecurityError(event:SecurityErrorEvent) : void
        {
            response.errorMessage = event.text;
            requestFailed.dispatch(response);
            return;
        }// end function

        public function onHTTPStatus(event:HTTPStatusEvent) : void
        {
            response.status = event.status;
            switch(event.status)
            {
                case 0:
                {
                    response.success = true;
                    break;
                }
                case 200:
                {
                    response.success = true;
                    break;
                }
                default:
                {
                    response.errorMessage = "HTTP Error " + event.status.toString();
                    break;
                }
            }
            return;
        }// end function

        public function onComplete(event:Event) : void
        {
            var event:* = event;
            if (response.success)
            {
                try
                {
                    switch(_responseEncoding)
                    {
                        case JSON_ENCODING:
                        {
                            response.data = JSON.decode(_loader.data as String);
                            break;
                        }
                        case XML_ENCODING:
                        {
                            break;
                        }
                        case TEXT_ENCODING:
                        {
                            break;
                        }
                        default:
                        {
                            throw new Error("HTTPServiceRequest.onComplete :: Invalid responseEncoding specified: " + _responseEncoding);
                            break;
                        }
                    }
                }
                catch (error:Error)
                {
                    response.errorMessage = error.name + ":: " + error.message;
                    requestFailed.dispatch(response);
                    return;
                }
                responseReceived.dispatch(response);
            }
            else
            {
                requestFailed.dispatch(response);
            }
            return;
        }// end function

    }
}
