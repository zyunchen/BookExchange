//
//  AddBookViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/16.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK:Properties
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookNameTextView: UITextField!
    
    var tapRecognizer: UITapGestureRecognizer? = nil
    
    //MARK:Actions
    override func viewDidLoad() {
        /* Configure tap recognizer */
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddBookViewController.handleSingleTap(_:)))
        tapRecognizer?.numberOfTapsRequired = 1
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardDismissRecognizer()
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.superview?.frame.origin.y = 0.0
        self.removeKeyboardDismissRecognizer()
        self.unsubscribeToKeyboardNotifications()
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        //Hide the keyboard
        bookNameTextView.resignFirstResponder()
        //UIImagePickerController is a view controller that lets auser pick media from their photo library
        let imagePickerController = UIImagePickerController()
        //Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        //Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        //present image picker view controller.
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func didSubbmit(sender: AnyObject) {
        
        if let image  = bookCoverImageView.image,bookName = bookNameTextView.text{
            let file = Utils.getAVFileWithImage(image, filename:bookName + ".jpg")
            Utils.upLoadFileToAVOS(file, completion: { (success, error) in
                if success {
                    var book = Book()
                    book.bookCoverUrl = file.url
                    book.bookName = bookName
                    book.bookDonater = nil
                    self.postBookToServer(book)
                }else {
                    print("save image filed")
                    print(error.description)
                }
            })
        }else{
            print("image or name is nil")
        }
        

    }
    
    @IBAction func didCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func postBookToServer(book:Book){
        
        let post = AVObject(className: "BookList")
        post.setObject(book.bookCoverUrl, forKey: Book.AVOSConstant.bookCoverUrl)
        post.setObject(book.bookName, forKey: Book.AVOSConstant.bookName)
        post.setObject(book.bookDonater, forKey: Book.AVOSConstant.bookDonater)
        post.saveInBackgroundWithBlock { (succeeded, error) in
            if (succeeded){
                print("post a book to server successful")
            }
        }
    }
    
    //MARK:UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //The info dictionary contains multiple representations of the image, and this users the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //Set bookCoverImageView to display the selected image.
        bookCoverImageView.image = Utils.scaleToSize(selectedImage, size: CGSize(width: 390, height: 420))
        
        //Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

// MARK: - AddBookViewController (Show/Hide Keyboard)

extension AddBookViewController {
    
    func addKeyboardDismissRecognizer() {
        view.addGestureRecognizer(tapRecognizer!)
    }
    
    func removeKeyboardDismissRecognizer() {
        view.removeGestureRecognizer(tapRecognizer!)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddBookViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddBookViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if(view.superview?.frame.origin.y == 0.0){
            view.superview?.frame.origin.y -= getKeyboardHeight(notification) / 2
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.superview?.frame.origin.y = 0.0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
}
