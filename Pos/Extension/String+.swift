//
//  String+.swift
//  Pos
//
//  Created by Nam Ngây on 28/08/2021.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        if self.count > 100 {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegexLength = "^.{6,18}$"
        let password = NSPredicate(format:"SELF MATCHES %@", passwordRegexLength)
        return password.evaluate(with: self)
    }
    
    func isValidCharacter() -> Bool {
        let regex = ".*(^(.*([A-Z]).*([a-z]))|(([a-z]).*([A-Z]))).*"
        let password = NSPredicate(format:"SELF MATCHES %@", regex)
        return password.evaluate(with: self)
    }
    
    func hasSpecialCharacters() -> Bool {
        let regex = ".*[^A-Za-z].*"
        let password = NSPredicate(format:"SELF MATCHES %@", regex)
        return password.evaluate(with: self)
    }
    
    func stringByReplacingFirstOccurrenceOfString(
        target: String, withString replaceString: String) -> String
    {
        if self.prefix(2) == target {
            var str = self.dropFirst(2)
            str = replaceString + str
            return String(str)
        }
        return self
    }
    
    func toDate(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = DateFormat.YYYYMMDD.rawValue
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
        
    func changeDateToString() -> String? {
        return self.toDate(dateFormat: DateFormat.yyyyMMddHHmmssSSSSSSZ.rawValue)?.toString(format: DateFormat.ddMMYYYY) ?? "Chưa cập nhật"
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

enum DateFormat: String {
    case ddMMDotYYY = "dd/MM, yyyy"
    case HHmmDDMMYYYY = "HH:mm dd/MM/yyyy"
    case ddMMYYYY = "dd/MM/yyyy"
    case yyyyMMdd = "yyyy/MM/dd"
    case YYYYMMDD = "yyyy-MM-dd"
    case HH_mm_DD_MM_YYYY = "HH_mm_dd_MM_yyyy"
    case ddMMyyyyHHmm = "dd/MM/yyyy HH:mm"
    case HHmm = "HH:mm"
    case HHmmdd = "HH:mm / dd"
    case hhmma = "hh:mm a"
    case ddhhmma = "dd hh:mm a"
    case hhmmass = "hh:mm:ss a"
    case HHmmss = "HH:mm:ss"
    case yyyyMMddHHmmssSSSz = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
    case yyyyMMddHHmmssSSSSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMddHHmmssSSS = "yyyy-MM-dd HH:mm:ss.SSS"
    case MMddyyyyHHmm = "MM-dd-yyyy HH:mm"
    case MMMddyyyyHHmm = "MMM-dd-yyyy HH:mm"
    case MMMddyyyyhhmma = "MMM dd yyyy hh:mm a"
    case MMMddyyyyhhmmssa = "MMM dd, yyyy hh:mm:ss a"
    case MMMddyyyy = "MMM dd, yyyy"
    case MMMyyyy = "MMM yyyy"
    case MMyyyy = "MM/yyyy"
    case yyyyMMddHHmmssSSS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case yyyyMMddTHHmma = "yyyy-MM-dd hh:mm a"
    case ddMMyyyyTHHmmssa = "dd-MM-yyyy hh:mm:ss a"
    case MMM_dd = "MMM-dd"
    case dd = "dd"
    case E = "E"
    case EEEE = "EEEE"
    case MMM = "MMM"
    case EEEEMMMddyyyy = "EEEE, MMM dd, yyyy"
    case EEEEMMMMddyyyy = "EEEE, MMMM dd, yyyy"
    case yyyyMMddhhmm = "yyyy-HH-dd hh:mm"
    case yyyyMMddHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddMMMyyyyhhmma = "dd MMM yyyy hh:mm a"
    case ddMMMyyyy = "dd MMM yyyy"
    case ddMMMMyyyy = "dd MMMM yyyy"
    case ddMMMyyyyhhmmssa = "dd MMM yyyy hh:mm:ss a"
    case ddMMyyyyhhmma = "dd/MM/yy : hh:mm a"
    case MMMMdd = "MMMM dd"
    case MMMMddyyyy = "MMMM dd, yyyy"
    case LLL = "LLL"
    //08:36AM - 31/11/2019
    case hhmmaddMMYYYY = "hh:mm a - dd/MM/YYYY"
    case ddMMYYYYhhmm = "dd/MM/YYYY - HH:mm"
    case dotddMMYYYY = "dd.MM.yyyy"
}

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale.current
        let newDate = dateFormatter.string(from: self)
        
        return newDate
    }
}
