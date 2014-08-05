package  
{
	import com.bit101.components.TextArea;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author lizhi
	 */
	public class ImageTextArea extends TextArea
	{
		public var content : Sprite;
		protected var _mask:Sprite;
		private var imageParts:Array = [];
		public function ImageTextArea(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, text:String=""):void {
			super(parent, xpos, ypos, text);
		}
		
		public function addImage(dis:DisplayObject,width:Number,height:Number,indent:int=0):void {
			var line:String ="<p><textformat indent='"+indent+"' leading='"+height+"'>i</textformat></p>";
			text += line;
			draw();
			var part:ImagePart = new ImagePart;
			part.dis = dis;
			part.charI = textField.text.length - 2;
			imageParts.push(part);
			updateImagePos(part);
			line ="<p><textformat indent='"+width+"'>i</textformat></p>";
			text += line;
		}
		
		private function updateImagePos(part:ImagePart):void {
			var rect:Rectangle = textField.getCharBoundaries(part.charI);
			var dis:DisplayObject = part.dis;
			if (rect) {
				dis.x = rect.x;
				dis.y = rect.y + 3;
				if (dis.parent==null) {
					content.addChild(dis);
				}
			}else {
				if (dis.parent) {
					dis.parent.removeChild(dis);
				}
			}
			
		}
		
		override protected function updateScrollbar():void
		{
			super.updateScrollbar();
			for each(var part:ImagePart in imageParts) {
				updateImagePos(part);
			}
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			_mask = new Sprite();
			_mask.mouseEnabled = false;
			super.addChild(_mask);
			
			content = new Sprite();
			super.addChild(content);
			content.mask = _mask;
		}
		
		override public function draw():void
		{
			super.draw();
			
			_panel.setSize(_width, _height);
			_panel.draw();
			
			_tf.width = _width - 4;
			_tf.height = _height - 4;
			if(_html)
			{
				_tf.htmlText = _text;
			}
			else
			{
				_tf.text = _text;
			}
			if(_editable)
			{
				_tf.mouseEnabled = true;
				_tf.selectable = true;
				_tf.type = TextFieldType.INPUT;
			}
			else
			{
				_tf.mouseEnabled = _selectable;
				_tf.selectable = _selectable;
				_tf.type = TextFieldType.DYNAMIC;
			}
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
		}
		
	}

}
import flash.display.DisplayObject;

class ImagePart {
	public var dis:DisplayObject;
	public var charI:Number;
}