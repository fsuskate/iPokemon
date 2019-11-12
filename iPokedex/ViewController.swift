//
//  ViewController.swift
//  iPokedex
//
//  Created by Francisco Surroca on 11/7/19.
//  Copyright © 2019 Francisco Surroca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var pokemonArray: [Pokemon] = []
    var pokemonTableIdentifier = "pokemonTableIdentifier"
    let mainURL = "https://pokeapi.co/api/v2/pokemon" //?limit=500"
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshPokemon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshPokemon() {
        if let url = URL(string: mainURL) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                        let results = json["results"] as! [[String:Any]]
                        
                        for (result) in results {
                            let temp = Pokemon(name: result["name"] as! String, url: result["url"] as! String)
                            self.pokemonArray.append(temp)
                        }
                        
                        self.getPokemonDetails()
                        
                        // releod the table after all the data is populated
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getPokemonDetails() {
        for (pokemon) in pokemonArray {
            if let url = URL(string: pokemon.url!) {
                URLSession.shared.dataTask(with: url) {
                    (data, response, error) in
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                            let sprites = json["sprites"] as! [String:Any]
                            let front = sprites["front_default"] as! String
                            pokemon.imageUrl = front
                            pokemon.height = json["height"] as! Int
                            pokemon.weight = json["weight"] as! Int
                            
                            // releod the table after all the data is populated
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }.resume()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: pokemonTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell( style: UITableViewCellStyle.subtitle, reuseIdentifier: pokemonTableIdentifier)
        }
        let pokemon = pokemonArray[indexPath.row]
        cell?.textLabel?.text = pokemon.name
        cell?.detailTextLabel?.text = pokemon.url
        if (pokemon.imageUrl != nil) {
            let url = URL(string: pokemon.imageUrl!)
            if let data = try? Data(contentsOf: url!) {
                let image: UIImage = UIImage(data: data)!
                cell?.imageView?.image = image
                cell?.imageView?.highlightedImage = image
                
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonArray[indexPath.row]
        let viewController = PokemonViewController()
        viewController.pokemon = selectedPokemon
        viewController.mainViewController = self
        self.present(viewController, animated: true, completion: nil)
    }
}

