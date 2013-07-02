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
	public class SWFMatrix {
		
		public function SWFMatrix(data:SWFData) {
			data.synchBits();
			if ( data.readUBits(1) == 1) {
				// has scale values
				var scaleBits:int = data.readUBits(5);
				scaleX = data.readSBits(scaleBits) / 65536.0;
				scaleY = data.readSBits(scaleBits) / 65536.0;
			}
			if ( data.readUBits(1) == 1) {
				// has skew bits
				var skewBits:int = data.readUBits(5);
				skew0 = data.readSBits(skewBits) / 65536.0;
				snew1 = data.readSBits(skewBits) / 65536.0;
			}
			var translateBits:int = data.readUBits(5);
			translateX = data.readSBits(translateBits) / 65536.0;
			translateY = data.readSBits(translateBits) / 65536.0;
		}
		
		public var scaleX:Number;
		public var scaleY:Number;
		public var skew0:Number;
		public var snew1:Number;
		public var translateX:Number;
		public var translateY:Number;
		
	}
	
}