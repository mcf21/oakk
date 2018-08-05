//
//  HomeViewController.swift
//  OakkRN
//
//  Created by Marcel McFall on 4/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//
import UIKit
import CoreNFC
enum NFCPrefix: CGFloat {
  case beaconPrefix = 39494939403
}
class HomeViewController: UIViewController {
  
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var addTreeButton: UIButton!
    @IBOutlet weak var showTreeInfoButton: UIButton!
    var nfcReaderSession: NFCNDEFReaderSession?
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    showTreeInfoButton.layer.cornerRadius = 10
    self.view.applyGradient(colors: [OakkTheme.backgroundGradientStartColor,
                                     OakkTheme.backgroundGradientMiddleColor,
                                     OakkTheme.backgroundGradientBottomColor])
    addTreeButton.layer.cornerRadius = 10
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    @IBAction func addTreeTapped(_ sender: Any) {
      guard let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddTreeViewController") else { return }
      self.navigationController?.pushViewController(addViewController, animated: true)
    }
    
  @IBAction func showReact(_ sender: Any) {
    nfcReaderSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
    nfcReaderSession?.alertMessage = "Tap your phone to the NFC Chip to read tree info."
    nfcReaderSession?.begin()
//    showReactNativeScreen()
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
extension HomeViewController: NFCNDEFReaderSessionDelegate {
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
      guard let treeDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "TreeDetailsViewController") as? TreeDetailsViewController else { return }
      let eosService = EOSChainService()
      eosService.getTreeBlockInfo(forTreeId: String(treeId), completionBlock: { (eosBlock) in
        treeDetailsViewController.treeDetails = eosBlock
      })
      
//      let navigationController = UINavigationController(rootViewController: treeDetailsViewController)
//      navigationController.pushViewController(treeDetailsViewController, animated: true)
    
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
            }
  }
}


