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
    var displayDefaite : Double {
        get {
            return Double(Defaite.text!)!
        }
        set {
            Defaite.text = String(newValue)
            
        }
    }
    @IBOutlet weak var Egalite: UILabel!
    var displayEgalite : Double {
        get {
            return Double(Egalite.text!)!
        }
        set {
            Egalite.text = String(newValue)
            
        }
    }
    @IBOutlet weak var Gain: UILabel!
    var displayGain : Double {
        get {
            return Double(Gain.text!)!
        }
        set {
            Gain.text = String(newValue)
        
        }
    }
    @IBOutlet weak var Coeff: UIPickerView!
    @IBOutlet weak var EloAdversaire: UITextField!
    @IBOutlet weak var EloJoueur: UITextField!
    
    @IBOutlet weak var BottomConstraint: NSLayoutConstraint!
    
    var coeffForComputation: Double = 24
    var EloPlayer: Double? {
        get  {
            return Double(EloJoueur.text!)
        } set {
            joue()
        }
    }
    var EloOpp: Double?{
        get  {
            return Double(EloAdversaire.text!)
        } set {
            joue()
        }
    }
    
    
    let listCoeff: [String] = ["16","24","36"]
    
    override func viewWillAppear(_ animated: Bool) {
        EloJoueur.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Coeff.dataSource = self;
        self.Coeff.delegate = self;
        
        
        var CoeffAtDefaultPosition: String?
        
        CoeffAtDefaultPosition = "24"

        
        var defaultRowIndex = listCoeff.index(of: CoeffAtDefaultPosition!)
        if(defaultRowIndex == nil) { defaultRowIndex = 0 }
        Coeff.selectRow(defaultRowIndex!, inComponent: 0, animated: false)
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(EloViewController.keyboardShown(_:)),
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func EditOpp(_ sender: UITextField) {
        if let elo = Double(sender.text!) {
            EloOpp = elo
        }
        
    }
    @IBAction func EditPlayer(_ sender: UITextField) {
        if let elo = Double(sender.text!) {
            EloPlayer = elo
        }
    }
    
    func keyboardShown(_ notification: Notification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        
        let rawFrame = value.cgRectValue
        let keyboardFrame = view.convert(rawFrame!, from: nil)
        
        BottomConstraint.constant = keyboardFrame.height
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listCoeff.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listCoeff[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if(row == 0)
        {
            coeffForComputation = 16
        }
        else if(row == 1)
        {
            coeffForComputation = 24
        }
        else
        {
            coeffForComputation = 36
        }
        joue()
    }
    func joue(){
        if let a = EloPlayer {
            if let b = EloOpp {
                let diff = a-b

                
                let puissance = pow(10, Double(-diff/400))
                displayGain = round( 10*coeffForComputation*(1-1/(1+puissance)))/10
                displayEgalite = round( 10*coeffForComputation*(0.5-1/(1+puissance)))/10
                displayDefaite = round( 10*coeffForComputation*(0-1/(1+puissance)))/10
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    
    
}

