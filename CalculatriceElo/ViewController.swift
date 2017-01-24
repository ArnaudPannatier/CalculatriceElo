//
//  ViewController.swift
//  CalculatriceElo
//
//  Created by Arnaud Pannatier on 10.01.17.
//  Copyright © 2017 Arnaud Pannatier. All rights reserved.
//

import UIKit

class EloViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var Defaite: UILabel!
    @IBOutlet weak var Egalite: UILabel!
    @IBOutlet weak var Gain: UILabel!
    @IBOutlet weak var Coeff: UIPickerView!
    @IBOutlet weak var EloAdversaire: UITextField!
    @IBOutlet weak var EloJoueur: UITextField!
    
    @IBOutlet weak var BottomConstraint: NSLayoutConstraint!
    
    var coeffForComputation: Int = 12
    
    let listCoeff: [String] = ["12","24","36"]
    
    override func viewWillAppear(animated: Bool) {
        EloJoueur.becomeFirstResponder()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Coeff.dataSource = self;
        self.Coeff.delegate = self;
        
        
        var CoeffAtDefaultPosition: String?
        
        CoeffAtDefaultPosition = "12"

        
        var defaultRowIndex = listCoeff.indexOf(CoeffAtDefaultPosition!)
        if(defaultRowIndex == nil) { defaultRowIndex = 0 }
        Coeff.selectRow(defaultRowIndex!, inComponent: 0, animated: false)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(EloViewController.keyboardShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        
        BottomConstraint.constant = keyboardFrame.height
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listCoeff.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listCoeff[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            coeffForComputation = 12
        }
        else if(row == 1)
        {
            coeffForComputation = 24
        }
        else
        {
            coeffForComputation = 36
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

