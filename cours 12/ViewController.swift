//==============================================
import UIKit
//==============================================
class ViewController: UIViewController {
    //-----------------------
    @IBOutlet weak var back_1: UIView!
    @IBOutlet weak var front_1: UIView!
    @IBOutlet weak var back_2: UIView!
    @IBOutlet weak var front_2: UIView!
    @IBOutlet weak var back_3: UIView!
    @IBOutlet weak var front_3: UIView!
    @IBOutlet weak var back_4: UIView!
    @IBOutlet weak var front_4: UIView!
    
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var imgView4: UIImageView!
    
    @IBOutlet weak var card_1: UIView!
    @IBOutlet weak var card_2: UIView!
    @IBOutlet weak var card_3: UIView!
    @IBOutlet weak var card_4: UIView!
    
    var arrayOfImageViews: [UIImageView]!
    var arrayOfAnimalNames = ["panda.png", "panda.png", "penguin.png", "penguin.png"]
    var arrayOfRandomAnimalNames = [String]()
    var arrayChosenCards = [String]()
    var arrayOfCards = [UIView]()
    
    var arrayOfShowingBacks = [UIView]()
    var arrayOfHidingFronts = [UIView]()
    
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfImageViews = [imgView1, imgView2, imgView3, imgView4]
        randomAnimals()
        setImagesToCards()
    }
    //-----------------------
    @IBAction func showCard(_ sender: UIButton) {
        if arrayOfHidingFronts.count == 2 {
            return
        }
        switch sender.tag {
            case 0:
                flipCard(from: front_1, to: back_1)
                arrayOfCards.append(card_1)
            case 1:
                flipCard(from: front_2, to: back_2)
                arrayOfCards.append(card_2)
            case 2:
                flipCard(from: front_3, to: back_3)
                arrayOfCards.append(card_3)
            case 3:
                flipCard(from: front_4, to: back_4)
                arrayOfCards.append(card_4)
            default:
                break
        }
        arrayChosenCards.append(arrayOfRandomAnimalNames[sender.tag])
        verification()
    }
    //-----------------------
    func flipCard(from: UIView, to: UIView) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
            UIView.transition(with: from, duration: 1.0, options: transitionOptions, animations: {
                from.isHidden = true
        })
            UIView.transition(with: to, duration: 1.0, options: transitionOptions, animations: {
                to.isHidden = false
        })
    }
    //-----------------------
    func setImagesToCards() {
        var number = 0
        for imgView in arrayOfImageViews {
            imgView.image = UIImage (named: arrayOfRandomAnimalNames[number])
            number = number + 1
        }
    }
    
    //-----------------------
    func randomAnimals() {
        let numberOfAnimals = arrayOfAnimalNames.count
        for _ in 1...numberOfAnimals {
            let randomNumer = Int(arc4random_uniform(UInt32(arrayOfAnimalNames.count)))
            arrayOfRandomAnimalNames.append(arrayOfAnimalNames[randomNumer])
            arrayOfAnimalNames.remove(at: randomNumer)
        }
        }
    //-----------------------
    func verification() {
        if arrayChosenCards.count == 2 {
            if arrayChosenCards[0] == arrayChosenCards[1] {
                Timer.scheduledTimer(timeInterval: 2,
                                     target: self,
                                     selector: (#selector(hideCards)),
                                     userInfo: nil,
                                     repeats: false)
            } else {
                arrayOfCards = []
            }
            arrayChosenCards = []
        }
    }
    //-----------------------
    func hideCards() {
        arrayOfCards[0].isHidden = true
        arrayOfCards[1].isHidden = true
        arrayChosenCards = []
    }
    //-----------------------
    func reFlip() {
        for index in 0..<arrayOfShowingBacks.count {
            flipCard(from: arrayOfShowingBacks[index], to: arrayOfHidingFronts[index])
        }
        arrayOfShowingBacks = []
        arrayOfHidingFronts = []
    }
    //-----------------------


    
}
//==============================================
