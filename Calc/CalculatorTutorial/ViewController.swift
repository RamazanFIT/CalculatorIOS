//
//  ViewController.swift
//  CalculatorTutorial
//
//  Created by Сырлыбай Рамазан on 26.03.2024.
//

import UIKit

class ViewController: UIViewController
{

	@IBOutlet weak var calculatorWorkings: UILabel!
	@IBOutlet weak var calculatorResults: UILabel!
	
	var workings:String = ""
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		clearAll()
	}
	
	func clearAll()
	{
		workings = ""
		calculatorWorkings.text = ""
		calculatorResults.text = ""
	}

	@IBAction func equalsTap(_ sender: Any)
	{
		if(validInput())
		{
			let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
			let expression = NSExpression(format: checkedWorkingsForPercent)
			let result = expression.expressionValue(with: nil, context: nil) as! Double
			let resultString = formatResult(result: result)
			calculatorResults.text = resultString
		}
		else
		{
			let alert = UIAlertController(
				title: "Invalid Input",
				message: "Error",
				preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Okay", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func validInput() ->Bool
	{
		var count = 0
		var funcCharIndexes = [Int]()
		
		for char in workings
		{
			if(specialCharacter(char: char))
			{
				funcCharIndexes.append(count)
			}
			count += 1
		}
		
		var previous: Int = -1
		
		for index in funcCharIndexes
		{
			if(index == 0)
			{
				return false
			}
			
			if(index == workings.count - 1)
			{
				return false
			}
			
			if (previous != -1)
			{
				if(index - previous == 1)
				{
					return false
				}
			}
			previous = index
		}
		
		return true
	}
	
	func specialCharacter (char: Character) -> Bool
	{
        return char == "+" || char == "-" || char == "*" || char == "/";
	}
	
    func formatResult(result: Double) -> String {
           return result.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", result) : String(format: "%.2f", result)
   }
	
	@IBAction func allClearTap(_ sender: Any)
	{
		clearAll()
	}
	
	@IBAction func backTap(_ sender: Any)
	{
		if(!workings.isEmpty)
		{
			workings.removeLast()
			calculatorWorkings.text = workings
		}
	}
	
	func addToWorkings(value: String)
	{
		workings = workings + value
		calculatorWorkings.text = workings
	}
    
    @IBAction func operationTap(_ sender: UIButton) {
        if let operation = sender.titleLabel?.text {
            addToWorkings(value: operation)
        }
    }
}

