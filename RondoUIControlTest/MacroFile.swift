//
//  MacroFile.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/12.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

func macroIsiPhoneX() -> Bool {
    return ((UIScreen.main.bounds.size.width == 375 && UIScreen.main.bounds.size.height == 812) || (UIScreen.main.bounds.width == 812 && UIScreen.main.bounds.size.height == 375) ? true : false)
}

func macroRondoNavbarH() -> CGFloat {
    return (macroIsiPhoneX() ? 88.0 : 64.0)
}

func macroRondoTabbarH() -> CGFloat {
    return 49.0
}

func macroRondoStatubarH() -> CGFloat {
    return (macroIsiPhoneX() ? 44.0 : 20.0)
}

func macroRondHomeBarH() -> CGFloat {
    return (macroIsiPhoneX() ? 34.0 : 0.0)
}

var macroScreenWidth = UIScreen.main.bounds.size.width
var macroFullScreenHeight = UIScreen.main.bounds.size.height
var macroSafeScreenHeight = macroFullScreenHeight - macroRondHomeBarH()

func colorWithHex(hexStr : Int32) -> UIColor {
    let color = UIColor.init(red: ((CGFloat((hexStr & 0xFF0000) >> 16)) / 255.0), green: ((CGFloat((hexStr & 0xFF00) >> 8)) / 255.0), blue: ((CGFloat(hexStr & 0xFF)) / 255.0), alpha: 1.0)
    return color
}

func colorWithRGB(red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) -> UIColor {
    let color = UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    return color
}

func alertYellowColor() -> UIColor {
    let color = colorWithHex(hexStr: 0xf8b025)
    return color
}

func alertBlueColor() -> UIColor {
    let color = colorWithRGB(red: 255, green: 250, blue: 240, alpha: 1)
    return color
}










