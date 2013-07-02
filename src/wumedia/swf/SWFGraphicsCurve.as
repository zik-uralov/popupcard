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
	
	/**
	 * ...
	 * @author guojian@wu-media.com
	 */
	public class SWFGraphicsCurve extends SWFGraphicsElement {
		
		public function SWFGraphicsCurve(data:SWFData) {
			var numBits:uint = data.readUBits(4) + 2;
			_cx = data.readSBits(numBits) * 0.05;
			_cy = data.readSBits(numBits) * 0.05;
			_ax = data.readSBits(numBits) * 0.05;
			_ay = data.readSBits(numBits) * 0.05;
			
			_type = "C";
		}
		
		
		private var _cx:Number;
		private var _cy:Number;
		private var _ax:Number;
		private var _ay:Number;
		
		public function get cx():Number { return _cx; }
		public function get cy():Number { return _cy; }
		public function get ax():Number { return _ax; }
		public function get ay():Number { return _ay; }
	}
	
}