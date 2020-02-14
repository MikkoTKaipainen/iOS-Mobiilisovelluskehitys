//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Mikko Kaipainen on 10/02/2020.
//  Copyright © 2020 Mikko Kaipainen. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    var operation = 0
    var historyCalc: Double = 0
    
    
    
    // get numbers
    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true {
            calculationLabel.text = String(sender.tag)
            numberOnScreen = Double(calculationLabel.text!)!
            performingMath = false
        } else {
            calculationLabel.text = calculationLabel.text! + String(sender.tag)
            numberOnScreen = Double(calculationLabel.text!)!
        }
    }
    
    // get operations
    @IBAction func buttons(_ sender: UIButton) {
        if calculationLabel.text != "" && sender.tag != 11 && sender.tag != 16 {
            previousNumber = Double(calculationLabel.text!)!
            if sender.tag == 12 {
                calculationLabel.text = "\(previousNumber)/"
            }
            if sender.tag == 13 {
                calculationLabel.text = "\(previousNumber)X"
            }
            if sender.tag == 14 {
                calculationLabel.text = "\(previousNumber)-"
            }
            if sender.tag == 15 {
                calculationLabel.text = "\(previousNumber)+"
            }
            if sender.tag == 18 {
                calculationLabel.text = "\(previousNumber)%"
            }
            if sender.tag == 17 {
                calculationLabel.text = "\(previousNumber)√"
            }
            if sender.tag == 19 {
                calculationLabel.text = "\(previousNumber)x^"
            }
            
            operation = sender.tag
            performingMath = true
        }
            // perform calculations
        else if sender.tag == 16 {
            
            if operation == 12 {
                calculationLabel.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 13 {
                calculationLabel.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 14 {
                calculationLabel.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 15 {
                calculationLabel.text = String(previousNumber + numberOnScreen)
            }
            else if operation == 17 {
                calculationLabel.text = String(numberOnScreen.squareRoot())
            }
            else if operation == 18 {
                calculationLabel.text = String((previousNumber / 100) * numberOnScreen)
            }
            else if operation == 19 {
                calculationLabel.text = String(Int(pow(previousNumber,numberOnScreen)))
                
            }
        }
            // Empty calculator
        else if sender.tag == 11 {
            calculationLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    override func viewDidLoad() {
        getCalculations()
        historyLabel.text = "\(numberOnScreen)"
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveCalculations(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CalculationItem", in: context)
        let newCalculation = NSManagedObject(entity: entity!, insertInto: context)
        
        newCalculation.setValue(numberOnScreen, forKey: "calculation")
        getCalculations()
        historyLabel.text = calculationLabel.text

        
        do {
            try context.save()
            print("saved")
        } catch {
            print("Fail")
        }
    }
    
    func getCalculations() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CalculationItem")
        request.returnsObjectsAsFaults = true
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                numberOnScreen = data.value(forKey: "calculation") as! Double
                print(numberOnScreen)
            }
        }catch {
            print("Fail")
        }
    }
    
}
