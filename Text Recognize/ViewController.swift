//
//  ViewController.swift
//  Text Recognize
//
//  Created by Lovish Dogra on 30/11/16.
//  Copyright © 2016 Lovish Dogra. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, G8TesseractDelegate {
    
    //MARK: Constants
    let picker = UIImagePickerController()
    
    //MARK: IBOutlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    
    //MARK: IBAction
    @IBAction func chooseImageButton(_ sender: Any) {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func scanButton(_ sender: Any) {
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            tesseract.image = imageView.image?.g8_blackAndWhite()
            tesseract.recognize()
            
            textView.text = tesseract.recognizedText
        }
        
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


}

