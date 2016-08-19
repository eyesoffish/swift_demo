//
//  ViewController.swift
//  Fruit
//
//  Created by fengei on 16/6/16.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

var blurEffect:UIBlurEffect!
var backImageView:UIImageView!
var button:UIButton!
var home:UIImageView!
var titleImage:UIImageView!
class ViewController: UIViewController,MenuButtonDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myAdd()
        self.view.layer.borderColor = UIColor.whiteColor().CGColor
        self.view.layer.borderWidth = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func myAdd()
    {
        let screenWidth:CGFloat =  375
        let screenHeight:CGFloat = 667
        let buttonMenu = MenuButton(frame: BQAdaptationFrame(screenWidth/2-50,  120, 100, 100))
        let buttonMenu2 = MenuButton(frame: BQAdaptationFrame(screenWidth/2-50,  320, 100, 100))
        let buttonMenu3 = MenuButton(frame: BQAdaptationFrame(screenWidth/2-50, 520, 100, 100))
        
        buttonMenu.delegate = self
        buttonMenu2.delegate = self
        buttonMenu3.delegate = self
        
        buttonMenu3.buttonTitle = "水果知识"
        buttonMenu2.buttonTitle = "适宜人群"
        buttonMenu.buttonTitle = "水果种类"
        buttonMenu3.buttonImage = UIImage(named: "btn4.png")
        buttonMenu2.buttonImage = UIImage(named: "btn2.png")
        buttonMenu.buttonImage = UIImage(named: "btn.png")
        
        
        backImageView = UIImageView()
        backImageView.frame = self.view.bounds
        backImageView.image = UIImage(named: "back.jpg")
        
        
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = BQAdaptationFrame(0, 100, screenWidth, screenHeight-100)
        backImageView.addSubview(effectView)
        effectView.alpha = 1
        
        home = UIImageView(image: UIImage(named: "home4.png"))
        let homeFrame = BQAdaptationFrame(20, 10, screenWidth, 150)
        home.frame = homeFrame
        home.backgroundColor = UIColor.clearColor()
        home.layer.shadowColor = UIColor.greenColor().CGColor
        home.layer.shadowOpacity=0.5
        
        self.view.addSubview(backImageView);
        self.view.addSubview(home)
        self.view.addSubview(buttonMenu)
        self.view.addSubview(lineView(280))
        self.view.addSubview(buttonMenu2)
        self.view.addSubview(lineView(480))
        self.view.addSubview(buttonMenu3)
        
    }
    func buttonClick(sender: UIButton) {
        if sender.titleLabel?.text == "适宜人群"
        {
//            print("适宜人群")
            self.presentViewController(FruitKnowlegeViewController(), animated: true, completion: nil)
        }
        else if sender.titleLabel?.text == "水果知识"
        {
//            print("水果知识")
            let type = WhoCanEatViewController()
            self.presentViewController(type, animated: true, completion: nil)
        }
        else if sender.titleLabel?.text == "水果种类"
        {
            let type = FruitTypesViewController()
            self.presentViewController(type, animated: true, completion: nil)
//            print("水果种类")
        }
    }
    func lineView(pointY:CGFloat) -> UIView {
        let frame = BQAdaptationFrame(0, pointY, CGRectGetWidth(self.view.frame), 2)
        let line = UIView(frame: frame)
        line.backgroundColor = UIColor.whiteColor()
        return line
    }
}

