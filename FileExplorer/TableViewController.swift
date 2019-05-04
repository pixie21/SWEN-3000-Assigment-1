//
//  TableViewController.swift
//  FileExplorer
//
//  Created by GIC_UWI on 2019/5/2.
//  Copyright © 2019 GIC. All rights reserved.
//

import Foundation
import UIKit

class Tablecontrol: UITableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return 13
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:"Empty")
        let cell = tableView.dequeueReusableCell(withIdentifier: "filecell", for: indexPath)
        //self.tableView.setEditing(true, animated: true)
        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = String(indexPath.section)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:false)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
