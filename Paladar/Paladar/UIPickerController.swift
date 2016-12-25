//
//  UIPickerController.swift
//  Paladar
//
//  Created by Julio Salinas on 10/21/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class UIPickerController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    private let stateComponent = 0;
    private let zipComponent = 1;
    private var stateZips : [String : [String]]!
    private var states: [String]!
    private var zips: [String]!
    let applePie = UIImage(named:"applePie.jpeg")
    let cheesecake = UIImage(named:"cheesecake.jpg")
    let keyLime = UIImage(named:"keylime.jpg")
    let cremeBurle = UIImage(named:"cremeBrulee.jpg")
    let pumpkin = UIImage(named:"pumpkinPie.jpeg")
    
    let blackBean = UIImage(named:"blackBean.jpg")
    let chilli = UIImage(named:"chilliSoup.jpg")
    let chickenNoodle = UIImage(named:"chickenNoodle.jpg")
    let cheeseSoup = UIImage(named:"cheeseSoup.jpg")
    let creamChicken = UIImage(named:"creamChicken.jpg")
    
     let beef = UIImage(named:"beef.jpg")
     let chicken = UIImage(named:"chicken.jpg")
     let duck = UIImage(named:"duck.jpg")
     let fish = UIImage(named:"fish.jpg")
     let lamb = UIImage(named:"lamb.jpg")
     let pizza = UIImage(named:"pizza.jpg")
     let steak = UIImage(named:"steak.jpg")
    
    let antipasto = UIImage(named:"antipasto.jpg")
    let bluecheese = UIImage(named:"bluecheesechips.jpg")
    let calamari = UIImage(named:"calamari.jpg")
    let nachos = UIImage(named:"nachos.jpg")
    let wings = UIImage(named:"chickenwings.jpg")
    
    let bagel = UIImage(named:"bagel.jpg")
    let burger = UIImage(named:"burger.jpg")
    let gyro = UIImage(named:"gyro.jpg")
    let blt = UIImage(named:"blt.jpg")
    let hotdog = UIImage(named:"hotdog.jpg")
    
    let chef = UIImage(named:"chef.jpg")
    let cob = UIImage(named:"cob.jpg")
    let fruit = UIImage(named:"fruit.jpg")
    let  greek = UIImage(named:"greek.jpg")
    let caeser = UIImage(named:"caesar.jpg")
    
     let cajun = UIImage(named:"cajun.jpg")
     let middle = UIImage(named:"middle.jpg")
     let cari = UIImage(named:"cari.jpg")
     let indian = UIImage(named:"indian.jpg")
     let mexican = UIImage(named:"mexican.jpg")
    let china = UIImage(named:"china.jpg")
   
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var message: UILabel!
    
    
    
    @IBOutlet weak var doublePicker: UIPickerView!
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let stateRow = doublePicker.selectedRowInComponent(stateComponent);
        let zipRow = doublePicker.selectedRowInComponent(zipComponent);
        let state = states[stateRow];
        let zip = zips[zipRow];
        if(state == "Soups" && zip == "Black Bean Soup")
        {
            image1.image = blackBean
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Soups" && zip == "Cheese Soup")
        {
            image1.image = cheeseSoup
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is IPAs & Dark Lagers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Soups" && zip == "Chicken Cream Soup")
        {
            image1.image = creamChicken
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Ales & Pilsners"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Soups" && zip == "Chicken Noodle Soup")
        {
            image1.image = chickenNoodle
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Soups" && zip == "Chilli Soup")
        {
            image1.image = chilli
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Brown Ales & Dark Lagers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
            
        //Start of desserts
            
        }else if(state == "Desserts" && zip == "Apple Pie")
        {
            image1.image = applePie
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Desserts" && zip == "Cheesecake")
        {
            image1.image = cheesecake
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Stouts & Porters"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
        else if(state == "Desserts" && zip == "Creme Burle")
        {
            image1.image = cremeBurle
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Stouts & Porters"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
        else if(state == "Desserts" && zip == "Key Lime Pie")
        {
            image1.image = keyLime
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        } else if(state == "Desserts" && zip == "Pumpkin Pie")
        {
            image1.image = pumpkin
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Belgian Style"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
        //Start of entrees
        else if(state == "Entrees" && zip == "Beef")
        {
            image1.image = beef
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Amber Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Entrees" && zip == "Chicken")
        {
            image1.image = chicken
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Ales & Brown Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Entrees" && zip == "Duck")
        {
            image1.image = duck
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Belgian Style & Dark Lagers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Entrees" && zip == "Fish")
        {
            image1.image = fish
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers & Golden Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Entrees" && zip == "Lamb")
        {
            image1.image = lamb
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Brown Ales & Amber Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Entrees" && zip == "Pizza")
        {
            image1.image = pizza
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Ales & Dark Lagers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Entrees" && zip == "Steak")
        {
            image1.image = steak
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is IPAs & Brown Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
       /////Start of Appetizers
        else if(state == "Appetizers" && zip == "Antipasto")
        {
            image1.image = antipasto
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Appetizers" && zip == "Blue cheese chips")
        {
            image1.image = bluecheese
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Belgian Style"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Appetizers" && zip == "Nachos")
        {
            image1.image = nachos
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Ales & IPAs"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Appetizers" && zip == "Calamari")
        {
            image1.image = calamari
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pilsners & Golden Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Appetizers" && zip == "Wings")
        {
            image1.image = wings
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers & Golden Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
       /////Start of Sandwiches
        else if(state == "Sandwiches" && zip == "BLT")
        {
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Dark Lagers & Amber Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Sandwiches" && zip == "Bagels")
        {
            image1.image = bagel
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Amber Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        } else if(state == "Sandwiches" && zip == "Burgers")
        {
            image1.image = burger
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Dark Lagers & Amber Ales & IPAs"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Sandwiches" && zip == "Gyros")
        {
            image1.image = gyro
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Amber Ales & Dark Lagers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        } else if(state == "Sandwiches" && zip == "Hot Dog")
        {
            image1.image = hotdog
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Dark Lagers & Amber Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
        ////Salads
        else if(state == "Salads" && zip == "Chef Salad")
        {
            image1.image = chef
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Salads" && zip == "Caeser Salad")
        {
            image1.image = caeser
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers & Golden Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Salads" && zip == "Cobb Salad")
        {
            image1.image = cob
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Salads" && zip == "Greek Salad")
        {
            image1.image = greek
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers,Pilsners & Pale Lagers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Salads" && zip == "Salad with Fruit")
        {
            image1.image = fruit
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Wheat Beers"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
        //Styles of Food
        else if(state == "Food Styles" && zip == "Cajun")
        {
            image1.image = cajun
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Lagers, & Golden Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Food Styles" && zip == "Caribbean")
        {
            image1.image = cari
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pilsners & Pale Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Food Styles" && zip == "Chinese")
        {
            image1.image = china
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Lagers,Pilsners & Golden Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Food Styles" && zip == "Indian")
        {
            image1.image = indian
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pilsners & IPAs"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Food Styles" && zip == "Middle Eastern")
        {
            image1.image = middle
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is Pale Lagers, & Pale Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }else if(state == "Food Styles" && zip == "Mexican")
        {
            image1.image = mexican
            let title = "Yummy you have selected \(zip)"
            let message = "Best beer option is IPAs, Pilsners & Pale Ales"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil);
            alert.addAction(action);
            presentViewController(alert, animated: true, completion: nil);
        }
        
    }
    
    
    
    
    
//    var data = ["Food Styles","Appetizers"]
//    var styles = ["Cajun","Italian","Chinese","Mexican","Carribean"]
//    var app = ["Antipasto","Blue Cheese Chips","Chinese","Calamari","Caviar"]
//    var salada = ["Ceaser","Chef Salad","Greek Salad","Salad with Fruit","California Cob"]
//    var sopa = ["Black Bean Soup "]
//    var inputTaxRate : String!
//    let stateInfo:[(name: String, tax: String)] = [("Food Styles", "Appetizers"+"somebs"+"more bs"), ("Illinois", "7.000"), ("Oregon", "8.000"), ("Wisconsin", "9.000")]
//    var styles = ["Cajun","Italian","Chinese","Mexican","Carribean"]
//    var app = ["Antipasto","Blue Cheese Chips","Chinese","Calamari","Caviar"]
    // var data2 = [["Appetizers"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("foodInfo", withExtension: "plist")
       // print(plistURL!);
        stateZips = NSDictionary(contentsOfURL: plistURL!) as! [String : [String]]
      //  print(stateZips)
        let allStates = stateZips.keys
        states = allStates.sort()
        //print = sorted(states)
        let selectedState = states[0]
        zips = stateZips[selectedState]
        //print(zips)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // returns the number of 'columns' to display.
    @available(iOS 2.0, *)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 2
        //return data2.count
    }
    
    // returns the # of rows in each component..
    @available(iOS 2.0, *)
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == stateComponent{
            return states.count
        }else{
            return zips.count
        }
        
    }
   
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if component == stateComponent{
            return states[row]
        }else{
            return zips[row]
        }
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == stateComponent{
            let selectedState = states[row]
            zips = stateZips[selectedState]
            doublePicker.reloadComponent(zipComponent)
            doublePicker.selectRow(0, inComponent: zipComponent, animated: true)
        
    }
    
    }
    
    
}


    


    
//    var Nations = [Any]()
//    var England = [Any]()
//    var Espana = [Any]()
//    var Germany = [Any]()
   

   // var club = "\(Nations[row])"
    
    

//    var data = [["Food Styles","Appetizers"],["Cajun","Caribbean","Chinese","Indian","Italian","uwd"],["Antipasto","Blue Cheese Chips","Chinese","Calamari","Caviar"]]
   // var data2 = [["Appetizers"]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//    }

//    func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }



//neeed this
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//       //var club = "\(Nations[row])"
//        if component == 0 {
//             club = "\(Nations[row])"
//            pickerView.reloadComponent(1)
//        }
//    }
  ////need this
//    // returns the number of 'columns' to display.
//    @available(iOS 2.0, *)
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
//        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//           //var club = "\(Nations[row])"
//            if component == 0 {
//                return Nations.count
//            }
//            else {
//                if (club == "Espana") {
//                    return Espana.count
//                }
//                if (club == "Germany") {
//                    return Germany.count
//                }
//                else {
//                    return England.count
//                }
//            }
//            return 0
//        }
//    }

    // returns the # of rows in each component..
//    @available(iOS 2.0, *)
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//        return data[component].count
//    }





// need this
//    func pickerView(thePickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0 {
//            return Nations[row]
//        }
//        else {
//            if (club == "Espana") {
//                return Espana[row]
//            }
//            if (club == "Germany") {
//                return Germany[row]
//            }
//            else {
//                return England[row]
//            }
//        }
//        return ""
//    }
//    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
//        
//    }



