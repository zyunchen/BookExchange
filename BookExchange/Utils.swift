//
//  Utils.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/17.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//
struct Utils {
    
    static func upLoadFileToAVOS(file:AVFile,completion:((Bool,NSError!) -> Void)?){
        file.saveInBackgroundWithBlock { (success, error) in
            if let completion = completion {
                completion(success,error)
            }
        }
    }
    
    static func getAVFileWithImage(image:UIImage,filename:String) -> AVFile {
        let data = UIImageJPEGRepresentation(image, 1.0)
        let file = AVFile(name:filename, data: data)
        return file!
    }
    
    //MARK:UIImage
    static func scaleToSize(image:UIImage,size:CGSize) -> UIImage {
        var width = CGFloat(CGImageGetWidth(image.CGImage))
        var height = CGFloat(CGImageGetHeight(image.CGImage))
        let verticalRadio = size.height/height
        let horizontalRadio = size.width/width
        let radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio
        width = width * radio
        height = height * radio
        
        let xPos = (size.width - width) / 2
        let yPos = (size.height - height) / 2
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(xPos, yPos, width, height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
}
