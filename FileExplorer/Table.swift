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
    
    
    @IBOutlet var bckbtn: UIBarButtonItem!
    //@IBOutlet var tableView: UITableView!
     var url = URL(string: "http://127.0.0.1:8000/?folder=")
    var filenames = [File]()
    var foldernum:Int = 0
    var filenum:Int = 0
    var files = [String]()
    final let slash:String = "//"
    //var street:Int = 0
    var file_names = [String]()
    var clicked_folder:String=""
    //    let foldername = Array
    let sectionTitles: [String] = ["Folders", "Files"]
    var current_folder:String=""
    var backcount:Int=0
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Root View";
        self.navigationItem.leftBarButtonItem=nil
        
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
                self.current_folder = downloadedfiles.current
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
    
    @IBAction func previous(_sender:UIBarButtonItem){
        print("Pressed")
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected \( self.file_names[(indexPath.row)])")
        
        self.backcount=self.backcount+1
        if self.backcount > 0 {
            self.navigationItem.leftBarButtonItem = self.bckbtn
            self.clicked_folder = self.file_names[(indexPath.row)]
            var urls=(string:"")
            urls = self.current_folder+"/"+self.clicked_folder
            self.url = URL(string:"http://127.0.0.1:8000/?folder=\(urls)")
            sessionLoadData(downloadURL: url!)
            print(self.url)
            tableView.reloadData()
        }
        
//        let currentCell = self.tableView.cellForRow(at: indexPath) as UITableViewCell!;
        //print(indexPath.row)
       
        
    }
    
   
    
    class Toast
    {
        class private func showAlert(backgroundColor:UIColor, textColor:UIColor, message:String)
        {
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let label = UILabel(frame: CGRect.zero)
            label.textAlignment = NSTextAlignment.center
            label.text = message
            label.font = UIFont(name: "", size: 15)
            label.adjustsFontSizeToFitWidth = true
            
            label.backgroundColor =  backgroundColor //UIColor.whiteColor()
            label.textColor = textColor //TEXT COLOR
            
            label.sizeToFit()
            label.numberOfLines = 4
            label.layer.shadowColor = UIColor.gray.cgColor
            label.layer.shadowOffset = CGSize(width: 4, height: 3)
            label.layer.shadowOpacity = 0.3
            label.frame = CGRect(x: appDelegate.window!.frame.size.width, y: 64, width: appDelegate.window!.frame.size.width, height: 44)
            
            label.alpha = 1
            
            appDelegate.window!.addSubview(label)
            
            var basketTopFrame: CGRect = label.frame;
            basketTopFrame.origin.x = 0;
            
            UIView.animate(withDuration
                :2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
                    label.frame = basketTopFrame
            },  completion: {
                (value: Bool) in
                UIView.animate(withDuration:2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                    label.alpha = 0
                },  completion: {
                    (value: Bool) in
                    label.removeFromSuperview()
                })
            })
        }
        
        class func showPositiveMessage(message:String)
        {
            showAlert(backgroundColor: UIColor.green, textColor: UIColor.white, message: message)
        }
        class func showNegativeMessage(message:String)
        {
            showAlert(backgroundColor: UIColor.red, textColor: UIColor.white, message: message)
        }
    }
}

