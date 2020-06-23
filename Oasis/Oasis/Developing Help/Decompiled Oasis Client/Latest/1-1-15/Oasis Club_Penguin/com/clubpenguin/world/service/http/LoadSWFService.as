package com.clubpenguin.world.service.http
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import org.osflash.signals.*;
    import org.robotlegs.mvcs.*;

    public class LoadSWFService extends Actor
    {
        public var response:LoadSWFResponse;
        public var responseReceived:Signal;
        public var requestFailed:Signal;
        private var _url:String;
        private var _props:Object;
        private var _movieClipLoader:Loader;
        private var _request:URLRequest;

        public function LoadSWFService()
        {
            responseReceived = new Signal(LoadSWFResponse);
            requestFailed = new Signal(LoadSWFResponse);
            return;
        }// end function

        public function onIOError(event:IOErrorEvent) : void
        {
            response.errorMessage = event.text;
            requestFailed.dispatch(response);
            return;
        }// end function

        public function onSecurityError(event:SecurityErrorEvent) : void
        {
            response.errorMessage = event.text;
            requestFailed.dispatch(response);
            return;
        }// end function

        public function setURL(param1:String, param2:Object = null) : void
        {
            _url = param1;
            if (param2)
            {
                _props = param2;
            }
            return;
        }// end function

        public function send() : void
        {
            _request = new URLRequest(_url);
            response = new LoadSWFResponse();
            response.id = _url;
            var _loc_1:* = ApplicationDomain.currentDomain;
            var _loc_2:* = new LoaderContext(false, _loc_1);
            _movieClipLoader = new Loader();
            _movieClipLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            _movieClipLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _movieClipLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _movieClipLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            _movieClipLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _movieClipLoader.contentLoaderInfo.addEventListener(Event.UNLOAD, onUnload);
            _movieClipLoader.load(_request, _loc_2);
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

        public function onProgress(event:ProgressEvent) : void
        {
            return;
        }// end function

        public function onUnload(event:Event) : void
        {
            return;
        }// end function

        public function onComplete(event:Event) : void
        {
            var event:* = event;
            _movieClipLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            _movieClipLoader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _movieClipLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _movieClipLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
            _movieClipLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            _movieClipLoader.contentLoaderInfo.removeEventListener(Event.UNLOAD, onUnload);
            if (response.success)
            {
                try
                {
                    response.data = _movieClipLoader as DisplayObject;
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
