//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var charGuess: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    var phrase = ""
    var currChar: Character = " "
    var incorrectGuessCount: Int = 0
    var wordHolder: String = ""
   
    
    @IBAction func guess(_ sender: UIButton) {
        print(charGuess.text)
        if charGuess.text == "" {
            
        }
        else if isGuessCorrect(charGuess.text!, phrase) {
            let indexArr = getIndexes(phrase, currChar)
            wordHolder = addCorrectChar(currChar, indexArr, wordHolder)
            word.text = addSpacesForDisplay(wordHolder)
        } else {
            let incG: String = String(currChar) + " "
            incorrectGuesses.text = incorrectGuesses.text! + incG
            incorrectGuessCount += 1
            changeImage(incorrectGuessCount)
            print(incorrectGuessCount)
        }
        charGuess.text = ""
        
        if ifLost() {
            popUpAlertLoser()
        } else if (ifWon()) {
            popUpAlertWinner()
        }
    }
    
    func popUpAlertLoser() {
        let alertController = UIAlertController(title: "You Lost!", message:
            ("The phrase was: " + phrase), preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default,handler: startOverHandler))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func popUpAlertWinner() {
        let alertController = UIAlertController(title: "You won!", message:
            ("The phrase was: " + phrase), preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default,handler: startOverHandler))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func startOverHandler(alert: UIAlertAction!) {
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        wordHolder = turnPhraseToHidden(phrase)
        word.text = addSpacesForDisplay(wordHolder)
        incorrectGuesses.lineBreakMode = .byWordWrapping;
        incorrectGuesses.numberOfLines = 0;
        incorrectGuesses.text = "Incorrect Guesses: "
        currChar = " "
        incorrectGuessCount = 0
    

    }
    
    func ifWon() -> Bool {
        if wordHolder.contains("_") {
            return false
        } else {
            return true
        }
    }
    
    func ifLost() -> Bool {
        if incorrectGuessCount == 6 {
            return true
        } else {
        return false
        }
    }
    
    func addSpacesForDisplay(_ p:String) -> String {
        var s = ""
        let pArr = [Character](p.characters)
        for i in pArr {
            let temp: String = String(i) + " "
            s += temp
        }
        return s
    }
    
    func changeImage(_ count: Int) {
        if count == 1 {
            image.image = UIImage(named: "hangman2.gif")
        } else if count == 2 {
            image.image = UIImage(named: "hangman3.gif")
        } else if count == 3 {
            image.image = UIImage(named: "hangman4.gif")
        } else if count == 4 {
            image.image = UIImage(named: "hangman5.gif")
        } else if count == 5 {
            image.image = UIImage(named: "hangman6.gif")
        } else if count == 6 {
            image.image = UIImage(named: "hangman7.gif")
        } else {
            print("you lost")
        }
    }
    
    func addCorrectChar(_ char: Character, _ indexArr: [Int], _ wordChange: String) -> String {
        var strArr = [Character](wordChange.characters)
        var newStr = ""
        print("HERE: ")
        print(strArr)
        for i in indexArr {
            strArr[i] = char
            print("index: " + String(i))
        }
        print(strArr)
        for i in strArr {
            newStr += String(i)
            print(newStr)
        }
        return newStr
        
    }
    
    func getIndexes(_ phrase: String, _ char: Character) -> [Int] {
        let charArr = [Character](phrase.characters)
        var count = 0
        var arr = [Int]()
        for i in charArr{
            if i == char {
                arr.append(count)
            }
            count += 1
        }
        return arr
    }
    
    func turnPhraseToHidden(_ str: String) -> String {
        let charsArr = [Character](str.characters)
        var underscoreStr = ""
        for i in charsArr {
            if i == " " {
                underscoreStr += " "
            } else {
                underscoreStr += "_"
            }
        }
        print(underscoreStr)
        return underscoreStr
    }
    
    func isGuessCorrect(_ c: String, _ phrase: String) -> Bool {
        let cUpper = c.uppercased()
        let cArr = [Character](cUpper.characters)
        currChar = cArr[0]
        if phrase.contains(String(currChar)) {
            print("true")
            return true
        } else {
            print("false")
            return false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        wordHolder = turnPhraseToHidden(phrase)
        word.text = addSpacesForDisplay(wordHolder)
        incorrectGuesses.lineBreakMode = .byWordWrapping;
        incorrectGuesses.numberOfLines = 0;
        incorrectGuesses.text = "Incorrect Guesses: "
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
