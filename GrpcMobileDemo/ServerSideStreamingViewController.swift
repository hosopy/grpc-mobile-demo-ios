//
//  ServerSideStreamingViewController.swift
//  GrpcMobileDemo
//
//  Created by Keishi Hosoba on 2016/08/25.
//  Copyright © 2016年 hosopy. All rights reserved.
//

import Foundation
import UIKit
import RemoteClient

class ServerSideStreamingViewController: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func requestButtonPressed(sender: UIButton) {
        // For debug
        GRPCCall.useInsecureConnectionsForHost("localhost:50051")
        let service = STMRepository(host: "localhost:50051")
        
        let request = STMFetchRequest()
        request.numItems = 5
        
        var numReceivedItems = 0
        service.fetchWithRequest(request) { done, response, error in
            if let response = response {
                numReceivedItems += 1
                self.labelStatus.text = "Received \(numReceivedItems) items"
                print("Received item=\(response)")
            }
            
            if done {
                self.labelStatus.text = "Done (Received \(numReceivedItems) items)"
            }
        }
    }

}