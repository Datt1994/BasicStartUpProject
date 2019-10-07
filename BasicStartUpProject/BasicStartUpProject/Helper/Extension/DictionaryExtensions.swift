//
//  DictionaryExtensions.swift
//  coinbidz
//
//  Created by datt on 03/01/18.
//  Copyright © 2018 zaptechsolutions. All rights reserved.
//

// MARK: - Methods
import UIKit
public extension Dictionary {
	
	///  : Check if key exists in dictionary.
	///
	///		let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
	///		dict.has(key: "testKey") -> true
	///		dict.has(key: "anotherKey") -> false
	///
	/// - Parameter key: key to search for
	/// - Returns: true if key exists in dictionary.
	func has(key: Key) -> Bool {
		return index(forKey: key) != nil
	}
	
    ///  : Remove all keys of the dictionary.
	///
	///		var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
	///		dict.removeAll(keys: ["key1", "key2"])
	///		dict.keys.contains("key3") -> true
	///		dict.keys.contains("key1") -> false
	///		dict.keys.contains("key2") -> false
	///
	/// - Parameter keys: keys to be removed
    mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
	///  : JSON Data from dictionary.
	///
	/// - Parameter prettify: set true to prettify data (default is false).
	/// - Returns: optional JSON Data (if applicable).
	func jsonData(prettify: Bool = false) -> Data? {
		guard JSONSerialization.isValidJSONObject(self) else {
			return nil
		}
		let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
		return try? JSONSerialization.data(withJSONObject: self, options: options)
	}
	
	///  : JSON String from dictionary.
	///
	///		dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
	///
	///		dict.jsonString(prettify: true)
	///		/*
	///		returns the following string:
	///
	///		"{
	///		"testKey" : "testValue",
	///		"testArrayKey" : [
	///			1,
	///			2,
	///			3,
	///			4,
	///			5
	///		]
	///		}"
	///
	///		*/
	///
	/// - Parameter prettify: set true to prettify string (default is false).
	/// - Returns: optional JSON String (if applicable).
	func jsonString(prettify: Bool = false) -> String? {
		guard JSONSerialization.isValidJSONObject(self) else {
			return nil
		}
		let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
		guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
		return String(data: jsonData, encoding: .utf8)
	}
    
    ///  : Count dictionary entries that where function returns true.
	///
	/// - Parameter where: condition to evaluate each tuple entry against.
    /// - Returns: Count of entries that matches the where clousure.
    func count(where condition: @escaping ((key: Key, value: Value)) throws -> Bool) rethrows -> Int {
        var count: Int = 0
        try self.forEach {
            if try condition($0) {
                count += 1
            }
        }
        return count
    }

}

// MARK: - Operators

public extension Dictionary {
    
    ///  : Merge the keys/values of two dictionaries.
	///
	///		let dict : [String : String] = ["key1" : "value1"]
	///		let dict2 : [String : String] = ["key2" : "value2"]
	///		let result = dict + dict2
	///		result["key1"] -> "value1"
	///		result["key2"] -> "value2"
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    // MARK: - Operators
    
    ///  : Append the keys and values from the second dictionary into the first one.
	///
	///		var dict : [String : String] = ["key1" : "value1"]
	///		let dict2 : [String : String] = ["key2" : "value2"]
	///		dict += dict2
	///		dict["key1"] -> "value1"
	///		dict["key2"] -> "value2"
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }
	
    ///  : Remove contained in the array from the dictionary
	///
	///		let dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
	///		let result = dict-["key1", "key2"]
	///		result.keys.contains("key3") -> true
	///		result.keys.contains("key1") -> false
	///		result.keys.contains("key2") -> false
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    static func - (lhs: [Key: Value], keys: [Key]) -> [Key: Value] {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }
    
    ///  : Remove contained in the array from the dictionary
	///
	///		var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
	///		dict-=["key1", "key2"]
	///		dict.keys.contains("key3") -> true
	///		dict.keys.contains("key1") -> false
	///		dict.keys.contains("key2") -> false
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    static func -= (lhs: inout [Key: Value], keys: [Key]) {
        lhs.removeAll(keys: keys)
    }

}

// MARK: - Methods (ExpressibleByStringLiteral)
public extension Dictionary where Key: ExpressibleByStringLiteral {
	
	///  : Lowercase all keys in dictionary.
	///
	///		var dict = ["tEstKeY": "value"]
	///		dict.lowercaseAllKeys()
	///		print(dict) // prints "["testkey": "value"]"
	///
	mutating func lowercaseAllKeys() {
		// http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
		for key in keys {
			if let lowercaseKey = String(describing: key).lowercased() as? Key {
				self[lowercaseKey] = removeValue(forKey: key)
			}
		}
	}
	
}
