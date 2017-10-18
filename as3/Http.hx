package as3;

import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.net.URLRequestHeader;

class Http {
	
	public var req : URLRequest;
	public var loader : URLLoader;
	
	public static var cookie : String;
	
	public static inline var DEBUG = false;
	
	public function new(url:String) {
		if ( DEBUG ) trace("pinging:" + url);
		var h = loader = new flash.net.URLLoader( );
		req = new flash.net.URLRequest(url);
		
		var d : Dynamic = cast req;
		d.cacheResponse = false;
		d.useCache = false;
		
		req.requestHeaders.push( new URLRequestHeader(SET_COOKIE, cookie) );
		
		h.addEventListener( HTTP_RESPONSE_STATUS,							statusHandler);
		h.addEventListener( flash.events.Event.COMPLETE,					dataHandler);
		h.addEventListener( flash.events.IOErrorEvent.IO_ERROR, 			errHandler);
		h.addEventListener( flash.events.IOErrorEvent.NETWORK_ERROR,		errHandler);
		h.addEventListener( flash.events.SecurityErrorEvent.SECURITY_ERROR, errHandler);
	}
	
	public static var DELETE = "DELETE";
	public static var PUT = "PUT";
	public static var POST = "POST";
	public static var SET_COOKIE = "Set-Cookie";
	public static var HTTP_RESPONSE_STATUS = "httpResponseStatus";
	
	public function addHeader(n, v){
		req.requestHeaders.push( new URLRequestHeader(n, v) );
	}
	
	public function forDelete(){
		req.method = DELETE;
	}
	
	public function forPut(data:String){
		req.method = PUT;
		req.data = data;
	}
	
	public function forPost(data:String){
		req.method = POST;
		var d = new flash.net.URLVariables();
		d.p = data;
		req.data = d;
	}
	
	public function dispose(){
		var h = loader;
		h.removeEventListener( HTTP_RESPONSE_STATUS								,statusHandler);
		h.removeEventListener( flash.events.Event.COMPLETE						,dataHandler);
		h.removeEventListener( flash.events.IOErrorEvent.IO_ERROR 				,errHandler);
		h.removeEventListener( flash.events.IOErrorEvent.NETWORK_ERROR			,errHandler);
		h.removeEventListener( flash.events.SecurityErrorEvent.SECURITY_ERROR	,errHandler);
		h.close();
		req = null;
		loader = null;
	}
	
	function statusHandler(d){
		var arr :Array<URLRequestHeader> = (cast d.responseHeaders);
		for ( h in arr )
			if ( h.name == SET_COOKIE )
				cookie = h.value;
	}

	function dataHandler(d : flash.events.Event){
		onResponse(loader.data);
	}
	
	function errHandler(d){
		onError( d );
	}
	
	public dynamic function onResponse( data : String ){
	}
	
	public dynamic function onError( data : String ){
	}
	
	public function request(){
		loader.load(req);
	}
	
}