/*
 Copyright 2019 Slicode
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
//  Created by Shankar B S on 19/01/19.
//  Copyright © 2019 Slicode. All rights reserved.
//

import Foundation
import UIKit

//Protocol Declaration
protocol PopoverContentControllerDelegate:class {
    func popoverContent(controller:PopoverContentController, didselectItem name:String)
}
//End Protocol

class PopoverContentController:UIViewController {
    let datasourceArray = ["Car", "Bike", "Bus", "Van", "bicycle"]
    static let CELL_RESUE_ID = "POPOVER_CELL_REUSE_ID"
    
    var updateIndex:IndexPath? // this is the index path of the cell need to update in the viewcontroller
    
    var delegate:PopoverContentControllerDelegate? //declare a delegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension PopoverContentController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: PopoverContentController.CELL_RESUE_ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: PopoverContentController.CELL_RESUE_ID)
        }
        cell?.textLabel?.text = datasourceArray[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    //MARK: Tableview Delegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVehicle = datasourceArray[indexPath.row]
        self.delegate?.popoverContent(controller: self, didselectItem: selectedVehicle)
        self.dismiss(animated: true, completion: nil)
    }
}
