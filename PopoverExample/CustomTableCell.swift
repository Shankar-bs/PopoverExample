/*
Copyright 2019 Slicode

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//  Created by Shankar B S on 26/01/19.
//  Copyright © 2019 Slicode. All rights reserved.
//

import Foundation
import UIKit

/* Declare a Delegate Protocol method */
protocol CustomTableCellDelegate:class {
    func customCell(cell:CustomTableCell, didTappedshow button:UIButton)
}

class CustomTableCell:UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    //Define delegate variable
    weak var cellDelegate:CustomTableCellDelegate?
    
    /* Call Delegate method from button action */
    @IBAction func showButtonAction(_ sender: Any) {
        let button = sender as! UIButton
        self.cellDelegate?.customCell(cell: self, didTappedshow: button)
    }
    //rest of the code

    class func getCustomCell() -> CustomTableCell {
        let cell = Bundle.main.loadNibNamed("CustomTableCell", owner: self, options: nil)?.last
        return cell as! CustomTableCell
    }
    
    override func awakeFromNib() {
    }
}
