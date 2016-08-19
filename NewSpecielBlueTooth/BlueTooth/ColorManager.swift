//
//  ColorManager.swift
//  BlueTooth
//
//  Created by fengei on 16/5/26.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import MultipeerConnectivity
protocol colorServiceManagerDelegate {
    func connectedDevicesChanged(manager:ColorManager,connectedDevies:[String])
    func colorChanged(manager:ColorManager,colorString:String)
}
class ColorManager: NSObject{
    var delegate:colorServiceManagerDelegate?
    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    private let colorServiceType = "example-color"
    private let myPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    private var serviceAdvertiser:MCNearbyServiceAdvertiser?
    private let serviceBrowser:MCNearbyServiceBrowser
    lazy var session:MCSession = {
        let session = MCSession(peer:self.myPeerID,securityIdentity: nil,encryptionPreference: MCEncryptionPreference.Required)
        session.delegate = self
        return session
    }()
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil,serviceType: colorServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID,serviceType: colorServiceType)
        super.init()
        self.serviceAdvertiser?.delegate = self
        self.serviceAdvertiser?.startAdvertisingPeer()
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
        
    }
    deinit
    {
        self.serviceAdvertiser?.stopAdvertisingPeer()
    }
    func sendColor(colorName:String)
    {
        if session.connectedPeers.count>0
        {
            do{
                try self.session.sendData(colorName.dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)!, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
            }
            catch let err as NSError
            {
                print(err)
            }
        }
    }

}
extension MCSessionState
{
    func stringValue() -> String
    {
        switch self {
        case .Connected:
            return "connected"
        case .Connecting:
            return "connecting"
        case .NotConnected:
            return "not connected"
        default:
            return "unknown"
        }
    }
}
extension ColorManager:MCSessionDelegate
{
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        print(data)
        self.delegate?.colorChanged(self, colorString: NSString(data: data,encoding: NSUTF8StringEncoding) as! String)
    }
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        print("\(state.stringValue())")
        self.delegate?.connectedDevicesChanged(self, connectedDevies: session.connectedPeers.map({$0.displayName}))
    }
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("didReceiveStream")
    }
    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: (Bool) -> Void) {
        print("didReceiveCertificate")
    }
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        print("didStartReceivingResourceWithName")
    }
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        print("didFinishReceivingResourceWithName")
    }
}
extension ColorManager:MCNearbyServiceBrowserDelegate
{
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print(peerID)
    }
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print(error)
    }
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print(peerID)
    }
}
extension ColorManager:MCNearbyServiceAdvertiserDelegate
{
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        print(error)
    }
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        print(peerID)
        invitationHandler(true,self.session)
    }
    
}
