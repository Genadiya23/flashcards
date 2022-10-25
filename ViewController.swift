//
//  ViewController.swift
//  flashcards
//
//  Created by Yana Sivakova on 9/13/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}


class ViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var card: UIView!
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        animateCardIn()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateNextPrevButtons()
        animateCardOut()
    }
    
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        // Do any additional setup after loading the view.
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Belarus", answer: "Minsk")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    @IBAction func didTaponFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    func flipFlashcard () {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight,
                          animations: {
            self.frontLabel.isHidden = true
        })
        frontLabel.isHidden = true
    }
    func animateCardOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.00, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn ()
        })
    }
    func animateCardIn (){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0.0)
        UIView.animate(withDuration: 0.3) {self.card.transform = CGAffineTransform.identity}
            self.updateLabels()
    }
    func updateNextPrevButtons () {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards [currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    func updateFlashcard(question:String, answer: String)  {
        let flashcard = Flashcard (question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        flashcards.append(flashcard)
        print ("Added a new flashcard")
        
        currentIndex = flashcards.count - 1
        
        updateNextPrevButtons()
        
        updateLabels()
    }
    
    func saveAllFlashcardsToDisk () {
        
        let dictionaryArray = flashcards.map {(card) -> [String: String] in return ["question": card.question, "answer":card.answer]
        }
        
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
    }
    
    func readSavedFlashcards (){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard (question: dictionary ["question"]!, answer: dictionary["answer"]!) }
            flashcards.append(contentsOf: savedCards)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
}
