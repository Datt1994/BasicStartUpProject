//
//  FloatExtensions.swift
//  coinbidz
//
//  Created by datt on 03/01/18.
//  Copyright © 2018 zaptechsolutions. All rights reserved.
//

import CoreGraphics

// MARK: - Properties
public extension Float {
	
	/// : Int.
	var int: Int {
		return Int(self)
	}
	
	/// : Double.
	var double: Double {
		return Double(self)
	}
	
	/// : CGFloat.
	var cgFloat: CGFloat {
		return CGFloat(self)
	}
	
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// : Value of exponentiation.
///
/// - Parameters:
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Float, rhs: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return pow(lhs, rhs)
}

prefix operator √
/// : Square root of float.
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
public prefix func √ (float: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return sqrt(float)
}
