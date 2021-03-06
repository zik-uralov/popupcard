﻿/*
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
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.IDataInput;

	/**
	 * @author guojian@wu-media.com
	 */
	public class SWFData implements IDataInput {
		
		public function SWFData(data:ByteArray) {
			_data = data;
			_data.endian = Endian.LITTLE_ENDIAN;
			synchBits();
		}
		
		protected var _data			:ByteArray;
		protected var _bitBuff		:int;
		protected var _bitPos		:int;
		
		public function synchBits():void {
			_bitBuff = 0;
			_bitPos = 0;
		}
		
		public function readSBits( bits:uint ):int {
			var result:int = readUBits(bits);
			if ( (result & (1 << (bits - 1))) != 0 ) {
				result |= -1 << bits;
			}
			return result;
		}
		
		public function readUBits( bits:uint ):uint	{			
			if ( bits == 0 ) {
				return 0;
			}
			var bitsLeft:int = bits;
			var result:int = 0;
			if ( _bitPos == 0 ) {
				_bitBuff = _data.readUnsignedByte();
				_bitPos = 8;
			}
			while ( true ) {
				var shift:int = bitsLeft - _bitPos;
				if ( shift > 0 ) {
					result |= _bitBuff << shift;
					bitsLeft -= _bitPos;
					
					_bitBuff = _data.readUnsignedByte();
					_bitPos = 8;
				} else {
					result |= _bitBuff >> - shift;
					_bitPos -= bitsLeft;
					_bitBuff &= 0xff >> (8 - _bitPos);
					break;
				}
			}
			return result;
        }
		
		public function readBoolean():Boolean{
			synchBits();
			return _data.readBoolean();
		}
		
		public function readByte():int{
			synchBits();
			return readByte();
		}
		
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void {
			synchBits();
			_data.readBytes( bytes, offset, length );
		}
		
		public function readDouble():Number{
			var bytes:ByteArray = new ByteArray();
			var double:ByteArray = new ByteArray();
			_data.readBytes(bytes, 0, 8);
			double.length = 8;
			double[0] = bytes[3];
			double[1] = bytes[2];
			double[2] = bytes[1];
			double[3] = bytes[0];
			double[4] = bytes[7];
			double[5] = bytes[6];
			double[6] = bytes[5];
			double[7] = bytes[4];
			double.position = 0;
			return double.readDouble();
		}
		
		public function readFloat():Number{
			synchBits();
			return _data.readFloat();
		}
		
		public function readInt():int{
			synchBits();
			return _data.readInt();
		}
		
		public function readMultiByte(length:uint, charSet:String):String{
			synchBits();
			return _data.readMultiByte(length, charSet);
		}
		
		public function readObject():*{
			synchBits();
			return _data.readObject();
		}
		
		public function readShort():int {
			synchBits();
			return _data.readShort();
		}
		
		public function readUnsignedByte():uint{
			synchBits();
			return _data.readUnsignedByte();
		}
		
		public function readUnsignedInt():uint{
			synchBits();
			return _data.readUnsignedInt();
		}
		
		public function readUnsignedShort():uint{
			synchBits();
			return _data.readUnsignedShort();
		}
		
		public function readUTF():String{
			synchBits();
			return _data.readUTF();
		}
		
		public function readUTFBytes(length:uint):String{
			synchBits();
			return _data.readUTFBytes(length);
		}
		
		public function get data()							:ByteArray { return _data; }
		public function set data(data:ByteArray)			:void { _data = data; synchBits(); }
		public function get position()						:int { return _data.position;	}
		public function set position(pos:int)				:void { _data.position = pos; }
		public function get bytesAvailable()				:uint{ return _data.bytesAvailable; }
		public function get endian()						:String{ return _data.endian; }
		public function set endian(type:String)				:void{ _data.endian = type; }
		public function get objectEncoding()				:uint{ return _data.objectEncoding; }
		public function set objectEncoding(version:uint)	:void{ _data.objectEncoding = version; }
	}
	
}