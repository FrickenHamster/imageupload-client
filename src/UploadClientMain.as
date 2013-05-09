/**
 * Created with IntelliJ IDEA.
 * User: Fricken Hamster
 * Date: 5/8/13
 * Time: 10:38 PM
 *
 */
package
{
import client.UploadClient;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.KeyboardEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.system.Security;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.ui.Keyboard;

public class UploadClientMain extends MovieClip
{
	
	public static const HOST_ADDRESS:String = "127.0.0.1";
	public static const POLICY_PORT:int = 12242;
	public static const SERVER_PORT:int = 12243;
	
	private var PreviewBitmap:Bitmap;
	private var PreviewCanvas:BitmapData;
	
	private var client:UploadClient;


	private var loader:Loader = new Loader();

	private var imageLinkBox:TextField;
	
	public function UploadClientMain()
	{

		Security.loadPolicyFile("xmlsocket://" + HOST_ADDRESS + ":" + POLICY_PORT);
		
		imageLinkBox = new TextField();
		
		imageLinkBox.x = 200;
		imageLinkBox.y = 670;
		imageLinkBox.width = 200;
		imageLinkBox.height = 20;
		
		
		imageLinkBox.type = TextFieldType.INPUT;
		imageLinkBox.text = "Input Link Here";
		imageLinkBox.border = true;
		imageLinkBox.multiline = false;
		
		addChild(imageLinkBox);
		
		
		PreviewCanvas = new BitmapData(400, 400);
		PreviewBitmap = new Bitmap(PreviewCanvas);
		
		graphics.lineStyle(1, 0x000000);
		graphics.moveTo(50, 50);
		graphics.lineTo(50, 650);
		graphics.lineTo(650, 650);
		graphics.lineTo(650, 50);
		graphics.lineTo(50, 50);
		
		client = new UploadClient();
		client.connect();
	}
	
	public function loadPreview():void
	{
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressStatus);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
		
		var fileRequest:URLRequest = new URLRequest(imageLinkBox.text);
		loader.load(fileRequest);
	}

	public function onProgressStatus(e:ProgressEvent):void
	{
		trace(e.bytesLoaded, e.bytesTotal);
	}

	public function onLoaderReady(e:Event):void
	{
		loader.width = 600;
		loader.height = 600;
		loader.x = 50;
		loader.y = 50;
		addChild(loader);
	}
	
	public function loadError(e:IOErrorEvent):void
	{
		imageLinkBox.text = "LOAD ERROR, TRY AGAIN";
	}
	
	
	public function keyDown(e:KeyboardEvent):void
	{
		switch (e.keyCode)
		{
			case (Keyboard.ENTER):
				loadPreview();
				break;
			
		}
	}
}
}
