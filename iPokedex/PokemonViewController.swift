//
//  PokemonViewController.swift
//  iPokedex
//
//  Created by Francisco Surroca on 11/11/19.
//  Copyright © 2019 Francisco Surroca. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    var pokemon: Pokemon?
    var mainViewController: ViewController?

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton()
        button.setTitle("<-Back", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 0, y: 25, width: 100, height: 20)
        button.addTarget(self, action: #selector(PokemonViewController.pressed(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        self.view.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = "Name:"
        label.frame = CGRect(x: 50, y: 55, width: 50, height: 20)
        self.view.addSubview(label)
        
        let textBox = UITextField()
        textBox.text = pokemon?.name
        textBox.frame = CGRect(x: 120, y: 57, width: 100, height: 20)
        textBox.layer.borderColor = UIColor.black.cgColor
        textBox.layer.borderWidth = 0
        self.view.addSubview(textBox)
        
        let labelUrl = UILabel()
        labelUrl.text = "URL:"
        labelUrl.frame = CGRect(x: 50, y: 85, width: 50, height: 20)
        self.view.addSubview(labelUrl)
        
        let textBoxUrl = UITextField()
        textBoxUrl.text = pokemon?.url
        textBoxUrl.frame = CGRect(x: 120, y: 87, width: 250, height: 20)
        self.view.addSubview(textBoxUrl)
        
        let labelHeight = UILabel()
        labelHeight.text = "Height:"
        labelHeight.frame = CGRect(x: 50, y: 115, width: 100, height: 20)
        self.view.addSubview(labelHeight)
        
        let textBoxHeight = UITextField()
        textBoxHeight.text = "\(pokemon!.height!)"
        textBoxHeight.frame = CGRect(x: 120, y: 117, width: 50, height: 20)
        self.view.addSubview(textBoxHeight)
        
        let labelWeight = UILabel()
        labelWeight.text = "Weight:"
        labelWeight.frame = CGRect(x: 50, y: 145, width: 100, height: 20)
        self.view.addSubview(labelWeight)
        
        let textBoxWeight = UITextField()
        textBoxWeight.text = "\(pokemon!.weight!)"
        textBoxWeight.frame = CGRect(x: 120, y: 147, width: 50, height: 20)
        self.view.addSubview(textBoxWeight)
        
        if (pokemon?.imageUrl != nil) {
            let url = URL(string: pokemon!.imageUrl!)
            if let data = try? Data(contentsOf: url!) {
                let image: UIImage = UIImage(data: data)!
                let imageView = UIImageView()
                imageView.image = image
                imageView.frame = CGRect(x: 50, y: 200, width: 150, height: 150)
                self.view.addSubview(imageView)
            }
        }
    }
    
    @objc func pressed(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
