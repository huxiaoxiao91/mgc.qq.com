// vim: tabstop=4 shiftwidth=4

// Copyright (c) 2011 , Yang Bo All rights reserved.
//
// Author: Yang Bo (pop.atry@gmail.com)
//
// Use, modification and distribution are subject to the "New BSD License"
// as listed at <url: http://www.opensource.org/licenses/bsd-license.php >.

package com.h3d.qqx5.util 
{
	public class Binary64
	{
		public var low:uint;
		/**
		 * @private
		 */
		public var internalHigh:uint;
		public function Binary64(low:uint = 0, high:uint = 0)
		{
			this.low = low;
			this.internalHigh = high;
		}
		/**
		 * Division by n.
		 * @return The remainder after division.
		 */
		public final function div(n:uint):uint
		{
			const modHigh:uint = internalHigh % n;
			const mod:uint = (low % n + modHigh * 6) % n;
			internalHigh /= n;
			const newLow:Number = NumberUtil.MakeNumber(low, modHigh) / n;
			internalHigh += uint(NumberUtil.GetHigh(newLow));
			low = newLow;
			return mod;
		}
		
		public final function mul(n:uint):void 
		{
			const newLow:Number = Number(low) * n;
			internalHigh *= n;
			internalHigh += uint(NumberUtil.GetHigh(newLow));
			low *= n;
		}
		
		public final function add(n:uint):void
		{
			const newLow:Number = Number(low) + n;
			internalHigh += uint(NumberUtil.GetHigh(newLow));
			low = newLow;
		}
		
		public final function bitwiseNot():void
		{
			low = ~low;
			internalHigh = ~internalHigh;
		}
		
		public final function equal(other:Binary64):Boolean
		{
			return this.low == other.low && this.internalHigh == other.internalHigh;
		}
	}
}
