//
//  CarnetViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 20/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit

class CarnetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

  var cellsFichier = [String]() //Création d'un tableau string vide pour manipulation
  var nombreCells:Int = 0
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // récupération des URL des fichiers txt stockés dans l'app
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            let txtFiles = directoryContents.filter{ $0.pathExtension == "txt" }
            print("txt urls:",txtFiles)
            let txtFileNames = txtFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("txt list:", txtFileNames)
            nombreCells = txtFileNames.count  //nombre de cellule dans la tableView
            cellsFichier=txtFileNames //Population du tableau créé précedemment
            
            //
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nombreCells

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        let cell = UITableViewCell(style:UITableViewCellStyle.default , reuseIdentifier: "cell")
      
        //Injection des valeurs du tableau dans les cellules
            cell.textLabel?.text = cellsFichier[indexPath.row]
        return(cell)
    }
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        navigationItem.title="Carnet" 

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
