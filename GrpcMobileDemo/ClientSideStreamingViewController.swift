//
//  ClientSideStreamingViewController.swift
//  GrpcMobileDemo
//
//  Created by Keishi Hosoba on 2016/08/25.
//  Copyright © 2016年 hosopy. All rights reserved.
//

import Foundation
import UIKit
import RemoteClient

class ClientSideStreamingViewController: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    
    private var service : STMRepository?
    private var requestBuffer : GRXBufferedPipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        // For debug
        GRPCCall.useInsecureConnectionsForHost("localhost:50051")
        service = STMRepository(host: "localhost:50051")
        requestBuffer = GRXBufferedPipe()
        
        service!.storeWithRequestsWriter(requestBuffer!) { response, error in
            if let response = response {
                self.labelStatus.text = response.message
            } else {
                self.labelStatus.text = "Error!"
                print("Error \(error)")
            }
        }
        
        labelStatus.text = "Service is ready!"
    }
    
    @IBAction func storeButtonPressed(sender: UIButton) {
        guard let requestBuffer = requestBuffer else { return }
        
        let item = STMItem()
        item.uuid = NSUUID().UUIDString
        item.name = "Item \(arc4random() % 10000 + 1)"
        
        requestBuffer.writeValue(item)
    }

    @IBAction func finishButtonPressed(sender: UIButton) {
        guard let requestBuffer = requestBuffer else { return }
        requestBuffer.writesFinishedWithError(nil)
    }
}
