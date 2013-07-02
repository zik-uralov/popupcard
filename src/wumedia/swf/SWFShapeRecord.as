/*
 * Copyright 2009 (c) Guojian Miguel Wu, guojian@wu-media.com.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
package wumedia.swf {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;	

	/**
	 * ...
	 * @author guojian@wu-media.com
	 */
	public class SWFShapeRecord {
		static private var _shape	:Shape = new Shape();
		
		static public function drawShape(graphics:*, shape:SWFShapeRecord, scale:Number, offsetX:Number = 0, offsetY:Number = 0):void {
			var x:Number = 0;
			var y:Number = 0;
			var elems:Array = shape.elements;
			var elemNum:int = -1;
			var elemLen:int = elems.length;
			var elem:SWFGraphicsElement;
			while ( ++elemNum < elemLen ) {
				elem = elems[elemNum];
				if ( elem.type == "M" ) {
					var move:SWFGraphicsMove = elem as SWFGraphicsMove;
					x = move.x * scale;
					y = move.y * scale;
					graphics.moveTo(offsetX + x, offsetY + y);
				} else if ( elem.type == "L" ) {
					var line:SWFGraphicsLine = elem as SWFGraphicsLine;
					x = x + line.dx * scale;
					y = y + line.dy * scale;
					graphics.lineTo(offsetX + x, offsetY + y);
				} else if ( elem.type == "C" ) {
					var curve:SWFGraphicsCurve = elem as SWFGraphicsCurve;
					var cx:Number = x + curve.cx * scale;
					var cy:Number = y + curve.cy * scale;
					x = cx + curve.ax * scale;
					y = cy + curve.ay * scale;
					graphics.curveTo(offsetX + cx, offsetY + cy, offsetX + x, offsetY + y);
				}
			}
		}
		
		public function SWFShapeRecord(data:SWFData, hasStyle:Boolean, hasAlpha:Boolean) {
			_hasStyle = hasStyle;
			_hasAlpha = hasAlpha;
			_elements = new Array();
			parse(data);
		}
		
		private var _numFillBits	:uint;
		private var _numLineBits	:uint;
		private var _hasStyle		:Boolean;
		private var _hasAlpha		:Boolean;
		private var _elements		:Array;
		private var _bounds			:Rectangle;
		
		private function parse(data:SWFData):void {
			var x:Number = 0;
			var y:Number = 0;
			var curve:SWFGraphicsCurve;
			var line:SWFGraphicsLine;
			var move:SWFGraphicsMove;
			data.synchBits();
			if ( _hasStyle ) {
				parseStyles(data);
				data.synchBits();
			}
			_numFillBits = data.readUBits(4);
			_numLineBits = data.readUBits(4);
			while ( true ) {
				var type:uint = data.readUBits(1);
				if ( type == 1 ) {
					// Edge shape-record
					if ( data.readUBits(1) == 0 ) {
						addElement(curve = new SWFGraphicsCurve(data));
						x = x + curve.cx;
						y = y + curve.cy;
						x = curve.cx + curve.ax;
						y = curve.cy + curve.ay;
					} else {
						addElement(line = new SWFGraphicsLine(data));
						x += line.dx;
						y += line.dy;
					}
				} else {
					// Change Record or End
					var flags:uint = data.readUBits(5);
					if ( flags == 0 ) {
						// end
						break;
					}
					var hasMoveTo :Boolean = (flags & 0x01) != 0;
					if ( hasMoveTo ) {
						addElement(move = new SWFGraphicsMove(data));
						x = move.x;
						y = move.y;
					}
					parseChangeRecord(data, flags);
				}
			}
			if ( _elements.length > 0 ) {
				calculateBounds();
			} else {
				_bounds = new Rectangle(0, 0, 0, 0);
			}
		}
		

		private function parseChangeRecord(data:SWFData, flags:uint):void {
			var hasNewStyles	:Boolean = (flags & 0x10) != 0;
			var hasLineStyle	:Boolean = (flags & 0x08) != 0;
			var hasFillStyle1	:Boolean = (flags & 0x04) != 0;
			var hasFillStyle0	:Boolean = (flags & 0x02) != 0;
			
			//TODO - styles logic not yet implemented
			if ( hasFillStyle0 ) {
				var fillStyle0:int;
				fillStyle0 = data.readUBits(_numFillBits);
			}
			if ( hasFillStyle1 ) {
				var fillStyle1:int;
				fillStyle1 = data.readUBits(_numFillBits);
			}
			if ( hasLineStyle ) {
				var lineStyle:int;
				lineStyle = data.readUBits(_numFillBits);
			}
			if ( hasNewStyles ) {
				parseStyles(data);
				_numFillBits = data.readUBits(4);
				_numLineBits = data.readUBits(4);
			}
		}
		
		private function parseStyles(data:SWFData):void {
			var i:int;
			
			var numFillStyles:int = data.readUnsignedByte();
			if ( numFillStyles == 0xff ) {
				numFillStyles = data.readUnsignedShort();
			}
			for ( i = 0; i < numFillStyles; ++i ) {
				parseFillStyle(data);
			}
			
			var numLineStyles:int = data.readUnsignedByte();
			if ( numLineStyles == 0xff ) {
				numLineStyles = data.readUnsignedShort();
			}
			for ( i = 0; i < numLineStyles; ++i ) {
				parseLineStyle(data);
			}
		}
		
		private function parseFillStyle(data:SWFData):void {
			//TODO - fillLogic logic not yet implemented
			var i:int;
			var fillType:int = data.readUnsignedByte();
			if ( fillType == 0x00 ) {
				// solid
				var fillColor:SWFColor;
				fillColor = new SWFColor(data, _hasAlpha);
			} else if ( fillType == 0x10 || fillType == 0x12 || fillType == 0x13 ) {
				// gradient - linear || radial || focal radial
				var fillMatrix:SWFMatrix;
				var numRatios:int;
				var ratios:Array;
				var colors:Array;
				fillMatrix = new SWFMatrix(data);
       			numRatios = data.readUnsignedByte();
				ratios = new Array(numRatios);
				colors = new Array(numRatios);
				for ( i = 0; i < numRatios; ++i ) {
					ratios[i] = data.readUnsignedByte();
					colors[i] = new SWFColor(data, _hasAlpha);
				}
			} else if ( fillType == 0x40 || fillType == 0x41 || fillType == 0x42 || fillType == 0x43 ) {
				// repeat bitmap || regular bitmap || non-smooth repeat || no-smooth regular
				var bitmapId:uint;
				var matrix:SWFMatrix;
				bitmapId = data.readUnsignedShort();
				matrix = new SWFMatrix(data);
			}
		}
		
		private function parseLineStyle(data:SWFData):void {
			//TODO - lineStyle logic not yet implemented
			var width:int;
			var color:SWFColor;
			width = data.readUnsignedShort();
			color = new SWFColor(data, _hasAlpha);
		}
		
		private function addElement(elem:SWFGraphicsElement):void {
			_elements.push(elem);
		}
		
		private function calculateBounds():void {
			var g:Graphics = _shape.graphics;
			g.clear();
			g.beginFill(0);
			drawShape(g, this, 1);
			g.endFill();
			_bounds = _shape.getRect(_shape);
		}
		
		public function get elements():Array { return _elements; }
		public function get bounds():Rectangle { return _bounds; }
	}
	
}