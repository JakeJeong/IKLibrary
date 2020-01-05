//
//  MainListTVC.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 03/09/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit


struct ExClass {
    var title : String?
    var description : String?
}
struct MenuModel {
    var title : String?
    var list : [ExClass?]
    var count : Int {
        return list.count
    }
}

class MainListTVC: UITableViewController {
    
    var list : [MenuModel?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        var popupModels = MenuModel(title: "IKPopup", list: [])
        popupModels.list.append(contentsOf: [
            ExClass(title: "IKPopup", description: "Default IKPopup"),
            ExClass(title: "CustomIKPopup", description: "Custom IKPopup"),
            ExClass(title: "SheetPopup", description: "Three Buttons IKPopup"),
            ExClass(title: "AttributedString Popup", description: "Use AttributedString")
        ])
        list.append(popupModels)
        
        var popupModel2s = MenuModel(title: "IKProgressHUD", list: [])
        popupModel2s.list.append(contentsOf: [
            ExClass(title: "IKProgressHUD show", description: "showProgress"),
            ExClass(title: "IKProgressHUD show Delay", description: "showProgress"),
            ExClass(title: "IKProgressHUD show Delay Completion", description: "showProgress"),
            ExClass(title: "IKProgressHUD dismiss", description: "dismissProgress"),
        ])
        list.append(popupModel2s)
        
        
        var popupModel3s = MenuModel(title: "IKCryptor", list: [])
        popupModel3s.list.append(contentsOf: [
            ExClass(title: "AES256Encrypt", description: "AES256Encrypt"),
            ExClass(title: "AES256Decrypt", description: "AES256Decrypt"),
            ])
        list.append(popupModel3s)
        
        let string1 = "대한민국"
        print("isKorean \(string1) -> ",string1.isKorean ? "true" : "false")
        
        let string2 = "https://www.naver.com"
        print("isURLType \(string2) -> ",string2.isURLType ? "true" : "false")
        
        print("isOnlyEng \(string1) -> ",string1.isOnlyEng ? "true" : "false")
        print("isOnlyEng \(string2) -> ",string2.isOnlyEng ? "true" : "false")
        
        print("findURL -> \(string2) ->", string2.findURL ?? "")
        print("findURL -> \(string1) ->", string1.findURL ?? "!! Not Found !!")
        
        self.tableView.reloadData()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let popmodels = self.list[section]
        return popmodels!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let popmodels = self.list[section] else {
            return nil
        }
        return popmodels.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        
        if let popmodels = self.list[indexPath.section], let exClass = popmodels.list[indexPath.row] {
            cell.textLabel?.text = exClass.title
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.text = exClass.description
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let popmodels = self.list[indexPath.section], let exClass = popmodels.list[indexPath.row] {
            switch (exClass.title) {
            case "CustomIKPopup" :
                Popup.openCustomPopup()
            case "IKPopup" :
                Popup.openIKPopup()
            case "SheetPopup" :
                Popup.openSheetPopup()
            case "AttributedString Popup" :
                Popup.openAttributedStringPopup()
            case "IKProgressHUD show" :
                IKProgressHUD.show()
            case "IKProgressHUD show Delay" :
                IKProgressHUD.show(dismissDelay: 3.0)
            case "IKProgressHUD show Delay Completion":
                IKProgressHUD.show(dismissDelay: 3.0) {
                    print("Completion IKProgressHUD Show")
                }
            case "IKProgressHUD dismiss" :
                IKProgressHUD.dismiss()
            default: break
                
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
