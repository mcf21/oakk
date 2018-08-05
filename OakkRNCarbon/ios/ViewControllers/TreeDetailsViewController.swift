//
//  TreeDetailsViewController.swift
//  OakkRN
//
//  Created by Marcel McFall on 4/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

import UIKit

class TreeDetailsViewController: UIViewController {
  @IBOutlet weak var treeOwnerLabel: UILabel!
  @IBOutlet weak var offsetCreditLabel: UILabel!
  @IBOutlet weak var treeCreationLabel: UILabel!
  
  var treeDetails: Row?
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.applyGradient(colors: [OakkTheme.backgroundGradientStartColor,
                                       OakkTheme.backgroundGradientMiddleColor,
                                       OakkTheme.backgroundGradientBottomColor])
        // Do any additional setup after loading the view.
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
