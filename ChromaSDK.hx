

@:enum 
abstract CHROMA_ID (String) from String to String{
	var CHROMA_NONE = "CHROMA_NONE";
	var CHROMA_STATIC = "CHROMA_STATIC";
	var CHROMA_CUSTOM = "CHROMA_CUSTOM";
	var CHROMA_CUSTOM2 = "CHROMA_CUSTOM2";
	var CHROMA_CUSTOM_KEY = "CHROMA_CUSTOM_KEY";
}

enum ChromaDevice{
	CDKeyboard;
	CDMouse;
	CDHeadset;
	CDMousepad;
	CDKeypad;
	CDChromalink;
}

typedef ChromaConf = {
	var supported : Array < ChromaDevice >;
}

class ChromaEffect{
	var id : String;
}

interface ChromaDeviceImpl {
	var type : ChromaDevice;
	function turnOff()					: Void;
	function color( c : Int ) 			: Void;
	function rebuildUrl() 				: Void;
}

class ChromaMousepad implements ChromaDeviceImpl{
	var api : ChromaSDK;
	var url : String;
	public var type = CDMousepad;
	
	public function new(api){
		this.api = api;
		rebuildUrl();
	}
	
	public function rebuildUrl(){
		url = api.URL + "/mousepad";
	}
	
	inline function getRequest(){
		var h = new as3.Http(url);
		h.addHeader("content-type", "application/json");
		return h;
	}
	
	public function turnOff(){
		var h = getRequest();
		h.forPut(api.json({effect:CHROMA_NONE}));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function color( c : Int ){
		var h = getRequest();
		var data = {
			effect:CHROMA_STATIC, 
			param: {
				color:api.bgr(c&0xffFFff),
			},
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			#if debug trace("cmp:"+data); #end
			h.dispose();
		};
	}
	
	public function matrixSize() return 15;
	
	public function matrix( c : Array<Int> ){
		var h = getRequest();
		var data = {
			effect:CHROMA_CUSTOM, 
			param: c,
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			//#if debug trace(data); #end
			h.dispose();
		};
	}
}

class ChromaMouse implements ChromaDeviceImpl{
	var api : ChromaSDK;
	var url : String;
	public var type = CDMouse;
	
	public function new(api){
		this.api = api;
		
		rebuildUrl();
	}
	
	public function rebuildUrl(){
		url = api.URL + "/mouse";
	}
	
	inline function getRequest(){
		var h = new as3.Http(url);
		h.addHeader("content-type", "application/json");
		return h;
	}
	
	public function turnOff(){
		var h = getRequest();
		h.forPut(api.json({effect:CHROMA_NONE}));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function color( c : Int ){
		var h = getRequest();
		var data = {
			effect:CHROMA_STATIC, 
			param: {
				color:api.bgr(c&0x00ffFFff),
			},
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			#if debug
			//trace(data);
			#end
			h.dispose();
		};
	}
	
	public function matrixRow() return 9;
	public function matrixColumn() return 7;
	public function matrixSize() return matrixRow()*matrixColumn();
	
	public function matrix( c : Array<Array<Int>> ){
		var h = getRequest();
		var data = {
			effect:CHROMA_CUSTOM2, 
			param: c,
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
}

class ChromaKeypad implements ChromaDeviceImpl{
	var api : ChromaSDK;
	var url : String;
	public var type = CDKeypad;
	
	public function new(api){
		this.api = api;
		rebuildUrl();
	}
	
	public function rebuildUrl(){
		url = api.URL + "/keypad";
	}
	
	inline function getRequest(){
		var h = new as3.Http(url);
		h.addHeader("content-type", "application/json");
		return h;
	}
	
	public function turnOff(){
		var h = getRequest();
		h.forPut(api.json({effect:CHROMA_NONE}));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function color( c : Int ){
		var h = getRequest();
		var data = {
			effect:CHROMA_STATIC, 
			param: {
				color:api.bgr(c),
			},
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function matrixRow() return 4;
	public function matrixColumn() return 5;
	public function matrixSize() return matrixRow()*matrixColumn();
	
	public function matrix( c : Array<Array<Int>> ){
		var h = getRequest();
		var data = {
			effect:CHROMA_CUSTOM, 
			param: c,
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
}

class ChromaKeyboard implements ChromaDeviceImpl{
	var api : ChromaSDK;
	var url : String;
	public var type = CDKeyboard;
	
	public function new(api){
		this.api = api;
		rebuildUrl();
	}

	public function rebuildUrl(){
		url = api.URL + "/keyboard";
	}
	
	inline function getRequest(){
		var h = new as3.Http(url);
		h.addHeader("content-type", "application/json");
		return h;
	}
	
	public function turnOff(){
		var h = getRequest();
		h.forPut(api.json({effect:CHROMA_NONE}));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function color( c : Int ){
		var h = getRequest();
		var data = {
			effect:CHROMA_STATIC, 
			param: {
				color:api.bgr(c),
			},
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function matrixRow() return 6;
	public function matrixColumn() return 22;
	public function matrixSize() return matrixRow()*matrixColumn();
	
	public function matrix( c : Array<Array<Int>> ){
		var h = getRequest();
		var data = {
			effect:CHROMA_CUSTOM, 
			param: c,
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
}

//have 5 leds
class ChromaHeadset extends ChromaLink{
	public function new(api){
		super(api);
		type = CDHeadset;
		rebuildUrl();
	}
	
	public override function rebuildUrl(){
		url = api.URL + "/headset";
	}
	
}

//have 5 leds
class ChromaLink implements ChromaDeviceImpl{
	var api : ChromaSDK;
	var url : String;
	public var type = CDChromalink;
	
	public function new(api){
		this.api = api;
		rebuildUrl();
	}
	
	public function rebuildUrl(){
		url = api.URL + "/chromalink";
	}
	
	inline function getRequest(){
		var h = new as3.Http(url);
		h.addHeader("content-type", "application/json");
		return h;
	}
	
	public function turnOff(){
		var h = getRequest();
		h.forPut(api.json({effect:CHROMA_NONE}));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	
	public function color( c : Int ){
		var h = getRequest();
		var data = {
			effect:CHROMA_STATIC, 
			param: {
				color:api.bgr(c&0x00ffFFff),
			},
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
	public function matrixSize() return 5;
	public function matrix( c : Array<Int> ){
		var h = getRequest();
		var data = {
			effect:CHROMA_CUSTOM, 
			param: c,
		};
		h.forPut(api.json(data));
		h.request();
		h.onError = h.onResponse = function(data){
			h.dispose();
		};
	}
}

class ChromaSDK {
	
	public static inline var 	DEBUG = true;
	public static function 		ALL_DEVICES() return Type.allEnums(ChromaDevice);
	public var URL = "http://localhost:54235/razer/chromasdk";
	
	public var initialised = false;
	
	public var MAX_ROW = 9;
	public var MAX_COLUMN = 7;
	
	public var MOUSEPAD_SIZE	=	15;
	
	var conf : ChromaConf;
	var sessionId : Int;
	var startTime  = haxe.Timer.stamp();
	
	public function new (){}
	
	public function init( conf : ChromaConf ){
		this.conf = conf;
		var h = new haxe.Http(URL);
		h.addHeader("content-type", "application/json");
		var data = haxe.Json.stringify({
            "title": "Razer Chroma SDK Sample Application",
            "description": "Razer Chroma SDK Sample Application",
            "author": {
                "name": "Chroma Developer",
                "contact": "www.razerzone.com"
            },
            "device_supported": [
                "keyboard",
                "mouse",
                "headset",
                "mousepad",
                "keypad",
                "chromalink"],
            "category": "application"
        });
		h.setPostData( data );
		h.request(true);
		h.onData = function(d:String){
			var data : Dynamic = haxe.Json.parse(d);
			trace(d);
			sessionId = data.sessionId;
			URL = data.uri;
			initialised = true;
			for ( d in devices())
				d.rebuildUrl();
		};
	}
	
	var mousepad:ChromaMousepad;
	public function getMousepad(){
		if (mousepad == null) mousepad = new ChromaMousepad(this);
		return mousepad;
	}
	
	var mouse:ChromaMouse;
	public function getMouse(){
		if (mouse == null) mouse = new ChromaMouse(this);
		return mouse;
	}
	
	var keypad:ChromaKeypad;
	public function getKeypad(){
		if (keypad == null) keypad = new ChromaKeypad(this);
		return keypad;
	}
	
	var keyboard:ChromaKeyboard;
	public function getKeyboard(){
		if (keyboard == null) keyboard = new ChromaKeyboard(this);
		return keyboard;
	}
	
	var chromalink:ChromaLink;
	public function getChromaLink(){
		if (chromalink == null) chromalink = new ChromaLink(this);
		return chromalink;
	}
	
	var headset:ChromaHeadset;
	public function getHeadset(){
		if (headset == null) headset = new ChromaHeadset(this);
		return headset;
	}
	
	var emptyArray = [];
	public function devices() : Array<ChromaDeviceImpl> {
		if ( !initialised ) return emptyArray;
		
		var a : Array<ChromaDeviceImpl> = [];
		if ( conf.supported.indexOf(CDChromalink) >= 0)	a.push(getChromaLink());
		if ( conf.supported.indexOf(CDKeyboard) >= 0) 	a.push(getKeyboard());
		if ( conf.supported.indexOf(CDMouse) >= 0) 		a.push(getMouse());
		if ( conf.supported.indexOf(CDMousepad) >= 0)	a.push(getMousepad());
		if ( conf.supported.indexOf(CDKeypad) >= 0) 	a.push(getKeypad());
		return a;
	}
	
	function getJsonRequest() : haxe.Http {
		var h = new haxe.Http(URL);
		h.addHeader("content-type", "application/json");
		return h;
	}
	
	public function uninit(){
		initialised = false;
		var h = new as3.Http(URL);
		h.addHeader("content-type", "application/json");
		
		#if debug
		h.onResponse = function(d){
			trace("uninit:"+d);
		}
		#end
		h.forDelete();
		h.request();
	}
	
	public function bgr( rgb:Int) : Int{
		var r = rgb & 0xff;
		var g = (rgb>>8) & 0xff;
		var b = (rgb >> 16) & 0xff;
		return b | (g << 8) | (r << 16);
	}
	
	public function json(d:Dynamic) return haxe.Json.stringify(d);
	
	static var api : ChromaSDK;
	
	public static function get(){
		
		if ( api != null ) return api;
		
		api = new ChromaSDK();
		
		return api;
	}
	
	public var heartBeatDelay = 2.0;
	
	var beat = 0.0;
	var prevTime = haxe.Timer.stamp();
	
	public function update(){
		var time = haxe.Timer.stamp();
		var dt = time - prevTime;
		
		updateDt(dt);
		
		prevTime = time;
	}
	
	function heartbeat(){
		if ( !initialised ) return;
		
		var h = new as3.Http(URL+"/heartbeat");
		h.addHeader("content-type", "application/json");
		h.forPut(null);
		h.request();
		
		#if debug
		h.onResponse = function(d){
			trace(d);
		}
		#end
	}
	
	function updateDt(dt){
		beat += dt;
		if ( beat >= heartBeatDelay ){
			heartbeat();
			beat = 0;
		}
	}
}