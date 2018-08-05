//
//  AddTreeViewController.swift
//  OakkRN
//
//  Created by Marcel McFall on 5/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

import UIKit
import CoreNFC
class AddTreeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    var nfcReaderSession: NFCNDEFReaderSession?
    override func viewDidLoad() {
      title = "Add a Tree"
        super.viewDidLoad()
      self.view.applyGradient(colors: [OakkTheme.backgroundGradientStartColor,
                                       OakkTheme.backgroundGradientMiddleColor,
                                       OakkTheme.backgroundGradientBottomColor])
      startButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
      nfcReaderSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
      nfcReaderSession?.alertMessage = "Tap your phone to the beacon to assign Tree to NFC."
      nfcReaderSession?.begin()
    }
    
  func showReactNativeScreen(_ treeId:String) {
    // Access Our Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // Create a new UIViewController
    let rnViewController = UIViewController()
    // Assign our rootView into the UIViewController
    let rootView = appDelegate.rootView
    rootView?.appProperties = ["nfcId": treeId]
    rnViewController.view = rootView
    // Present our new UIViewController
    self.present(rnViewController, animated: true, completion: nil)
  }

}
extension AddTreeViewController: NFCNDEFReaderSessionDelegate {
  var beaconPrefix: String {
    return "39494939403"
  }
  func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    print("Reader session invalidated with error: \(error.localizedDescription)")
  }
  
  
  
  func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    session.alertMessage = "Read Successful."
    // Step 2 - Read the ID of the Beacon
    guard let uniqueId = NFCHelper.extractNFCid(fromNDefMessages: messages) else { return }
    let treeId = uniqueId.dropFirst(20)
    print("This is the uniqueIdT", treeId)
    print("This is the uniqueIdN", uniqueId)
    DispatchQueue.main.sync {
      showReactNativeScreen(String(treeId))
    }
    
    //        viewModel.accessDoor(forDoorId: uniqueId) { [weak self] (response) in
    //            self?.nfcReaderSession?.alertMessage = "Access \(response!)"
    //            // Step 3 - Take action based on NFC Identification.
    //            DispatchQueue.main.async {
    //                let checkInView = self?.contactlessView.subviews[0] as? CheckinView
    //                checkInView?.update(viewTitle: "SOMETHING WENT WRONG",
    //                                    withDescription: "Tap here to try again",
    //                                    usingGradientColors:
    //                    [KuboTheme.contactLessErrorGradientStartColor, KuboTheme.contactLessErrorGradientEndColor])
    //            }
    //        }
  }
}
