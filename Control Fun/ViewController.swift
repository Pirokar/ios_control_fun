//
//  ViewController.swift
//  Control Fun
//
//  Created by Владимир Рыбалка on 19/07/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var percentField: UILabel!
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var rightSwitch: UISwitch!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var doSomethingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        percentField.text = "\(lroundf(sliderView.value))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textFieildDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let progress = lroundf(sender.value)
        percentField.text = "\(progress)"
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        nameField.resignFirstResponder()
        numberField.resignFirstResponder()
    }

    @IBAction func toggleControls(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            leftSwitch.isHidden = false
            rightSwitch.isHidden = false
            doSomethingBtn.isHidden = true
        } else {
            leftSwitch.isHidden = true
            rightSwitch.isHidden = true
            doSomethingBtn.isHidden = false
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        let setting = sender.isOn
        leftSwitch.setOn(setting, animated: true)
        rightSwitch.setOn(setting, animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Вы уверены?", message: nil, preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Да, уверен!", style: .destructive, handler: {ACTION in
            let msg = (self.nameField.text?.isEmpty)! ? "Можете вздохнуть спокойно, все хорошо" : "Можете вздохнуть спокойно, \(self.nameField!.text!),"
                                                   + " все хорошо"
            
            let notificatonController = UIAlertController(title: "Все прошло хорошо", message: msg, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Уф, пронесло!", style: .cancel, handler: nil)
            notificatonController.addAction(cancelAction)
            self.present(notificatonController, animated: true, completion: nil)
        })
        
        let noAction = UIAlertAction(title: "Ни за что!", style: .cancel, handler: nil)
        
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender as? UIView
            ppc.sourceRect = (sender as! UIView).bounds
            ppc.permittedArrowDirections = .down
        }
        
        present(controller, animated: true, completion: nil)
    }
}

