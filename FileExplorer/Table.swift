//
//  Table.swift
//  FileExplorer
//
//  Created by GIC_UWI on 2019/5/2.
//  Copyright © 2019 GIC. All rights reserved.
//

import Foundation
import UIKit

class Table: UITableViewController {
    //@IBOutlet var tableView: UITableView!
     var url = URL(string: "http://127.0.0.1:8000/?folder=")
    var filenames = [File]()
    var foldernum:Int = 0
    var filenum:Int = 0
    var files = [String]()
    //var street:Int = 0
    var file_names = [String]()
    var clicked_folder:String=""
    //    let foldername = Array
    let sectionTitles: [String] = ["Folders", "Files"]
    var current_folder:String=""
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionLoadData(downloadURL: url!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func sessionLoadData(downloadURL:URL) {
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
            
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong with the download")
                
                return
                
            }
            
            print("success")
            do {
                let decoder = JSONDecoder()
                
                let downloadedfiles = try decoder.decode(File.self, from: data)
                
                self.filenames = [downloadedfiles]
                DispatchQueue.main.async {
                    self.tableView.reloadData()                }
                
                //                let filenames = downloadedfiles.files
                self.foldernum = downloadedfiles.folders.count
                self.filenum = downloadedfiles.files.count
                self.files = downloadedfiles.files
                self.file_names = downloadedfiles.folders
                self.current_folder= downloadedfiles.current
                //                print(foldername[0])
            }catch{
                print("something went wrong after downloading")
            }
            }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return filenames.count
        //print(foldername)
        switch section {
            
        case 0:
            return foldernum
            
        case 1:
            return filenum
        default:
            return 0
        }
        //return foldernum + filenum
        
        //foldername.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //       let view = UIView()
        //        view.backgroundColor = UIColor.gray
        //
        //        let label = UILabel()
        //        label.text = sectionTitles[section]
        //        view.addSubview(label)
        //        return view
        
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        cell3.headerLabel.text = sectionTitles[section]
        
        return cell3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(files)
        //print(file_names[1])
        switch indexPath.section {
            
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Folders", for: indexPath) as! FileCell
            cell1.filenamelabel?.text = file_names[indexPath.row]
            return cell1
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Files", for: indexPath) as! FileCell
            cell2.filesname?.text = files[indexPath.row]
            return cell2
        default:
            print("Default Selected")
        }
        return cell
        
    }
    
    //        let cell1
    //        if indexPath.row == 0 {
    //            returnCell = tableView.dequeueReusableCell(withIdentifier: "Folders", for: indexPath)
    //            returnCell.filenamelabel?.text = file_names[indexPath.row]
    //        //cell.textLabel?.text = file_names[indexPath.row]
    //        return returnCell
    //        } else {
    //            returnCell = tableView.dequeueReusableCell(withIdentifier: "Files", for: indexPath)
    //            returnCell.filesname?.text = file_names[indexPath.row]        }
    //        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "Files") as? FileCell else { return UITableViewCell() }
    //        cell2.filesname?.text = files[indexPath.row]
    
    //
    //        let indexPath = tableView.indexPathForSelectedRow
    //        let myIndex = indexPath!.row
    //        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
    //        let currentItem = currentCell.textLabel!.text
    //        print(currentItem)
    //        let alertController = UIAlertController(title: "Simplified iOS", message: "YOu Selected" + currentItem!, preferredStyle: .alert)
    //        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
    //        alertController.addAction((defaultAction))
    //        //tableView.deselectRow(at: indexPath, animated:false)
    //
    //        present(alertController, animated: true, completion: nil)
    //        print(self.file_names[indexPath!.row])
    //l//et indexPath = tableView.indexPathForSelectedRow
    
    //        cell.parentnamelabel?.text = filenames[indexPath.row].parent
    //            cell.parentfolderLabel.text = filenames[indexPath.row].parent
    //        print(street)
    //
    //            street += 1
    //
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \( self.file_names[(indexPath.row)])")
//        let currentCell = self.tableView.cellForRow(at: indexPath) as UITableViewCell!;
        self.clicked_folder = self.file_names[(indexPath.row)]
        self.url = URL(string:"http://127.0.0.1:8000/?folder=\(self.clicked_folder)/")
        sessionLoadData(downloadURL: url!)
        print(self.url)
        
        tableView.reloadData()
        

//
//        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
//
//        let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
//
        //print(currentCell?.textLabel!.text)
//
                //print("Selected")
//        let indexPath = tableView.indexPathForSelectedRow
//        //myIndex = indexPath.row
//        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
//        let currentItem = currentCell.textLabel!.text
//        //print(currentItem)
//        let alertController = UIAlertController(title: "Simplified iOS", message: "YOu Selected" + currentItem!, preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
//        alertController.addAction((defaultAction))
//        //tableView.deselectRow(at: indexPath, animated:false)
//
//        present(alertController, animated: true, completion: nil)
//        print(self.file_names[(indexPath!.row)])
//        tableView.deselectRow(at: indexPath!, animated: false)
        //
    }//    func tableView(tableView: UITableView, didSelectRowAtIndexPath, indexPath: NSIndexPath){
    ////    }
    //func tableView
    
    
}

