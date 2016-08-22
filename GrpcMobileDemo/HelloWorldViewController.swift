//
//  HelloWorldViewController.swift
//  GrpcMobileDemo
//
//  Created by Keishi Hosoba on 2016/08/22.
//  Copyright © 2016年 hosopy. All rights reserved.
//

import Foundation
import UIKit
import RemoteClient

class HelloWorldViewController: UIViewController {
    
    @IBOutlet weak var labelStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestButtonPressed(sender: UIButton) {
        // For debug
        GRPCCall.useInsecureConnectionsForHost("localhost:50051")

        // Call RPC
        let request = HLWHelloRequest()
        request.name = "neko"

        let client = HLWGreeter(host: "localhost:50051")
        client.sayHelloWithRequest(request) { response, error in
            // response is HLWHelloReply
            if let response = response {
                self.labelStatus.text = response.message
            } else {
                print("Error \(error)")
            }
        }
    }
}