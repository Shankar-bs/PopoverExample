/*
 Copyright 2019 Slicode
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//  Created by Shankar B S on 19/01/19.
//  Copyright © 2019 Slicode. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPopoverPresentationControllerDelegate {
    var datasourceArray = ["Car", "Bike", "Bus", "Van", "bicycle"] //add datasource
    let CELL_REUSE_ID = "CUSTOM_CELL_REUSE_ID"
    @IBOutlet weak var myTableview: UITableView!
    @IBOutlet weak var showButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showPopoverButtonAction(_ sender: Any) {
        //get the button frame
        /* 1 */
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero
        
        /* 2 */
        //Configure the presentation controller
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverContentController") as? PopoverContentController
        popoverContentController?.modalPresentationStyle = .popover
        
        /* 3 */
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            /*Set the delegate */
            popoverContentController?.delegate = self
            
            if let popoverController = popoverContentController {
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    
    func showPopoverFrom(cell:CustomTableCell, forButton button:UIButton) {
       
        let buttonFrame = button.frame
        var showRect    = cell.convert(buttonFrame, to: myTableview)
        showRect        = myTableview.convert(showRect, to: view)
        showRect.origin.y -= 10
        
        /* Get the index of the cell */
        let indexPath = self.myTableview.indexPath(for: cell)
        /* */
    
        /* Rest is same as showing popoer */
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverContentController") as? PopoverContentController
        popoverContentController?.modalPresentationStyle = .popover
        
       
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = showRect
            popoverPresentationController.delegate = self
            popoverContentController?.delegate = self
            
            /*Set the index path*/
            popoverContentController?.updateIndex = indexPath
            
            if let popoverController = popoverContentController {
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    
    
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

extension ViewController:PopoverContentControllerDelegate {
    func popoverContent(controller: PopoverContentController, didselectItem name: String) {
        /* Comment below line */
        //showButton.setTitle(name, for: .normal)
        if let indexPath = controller.updateIndex {
            self.datasourceArray[indexPath.row] = name
            self.myTableview.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: Tableview Delegate and Datasource
extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the array count
        return datasourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:CELL_REUSE_ID) as? CustomTableCell
        if cell == nil {
            cell = CustomTableCell.getCustomCell()
        }
        //populate cell with the data
        cell?.cellLabel.text = datasourceArray[indexPath.row]
        //set the delegeate
        cell?.cellDelegate = self
        return cell!
    }
}

// Confirm to CustomTableCellDelegate and define the delegate method
extension ViewController:CustomTableCellDelegate {
    func customCell(cell: CustomTableCell, didTappedshow button: UIButton) {
        self.showPopoverFrom(cell: cell, forButton: button)
    }
}
