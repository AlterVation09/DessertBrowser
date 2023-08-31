//
//  StringUtil.swift
//  IDesserts
//
//  Created by Jesus Garcia ibarra on 30/08/23.
//

import Foundation

extension String {     //Check if a string is empty
    func isTrimmedEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty   //returns a new string with all of the whitespace and newlines removed from the beginning and end of the string
    }
}
