//
//  ViewController.swift
//  SimpleCamera
//
//  Created by Simon Ng on 25/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraButton:UIButton!
    
    // quan ly in out
    let captureSesstion = AVCaptureSession()
    //Selecting the input device
    // luu device
    var backFacingCamera:AVCaptureDevice?
    var frontFacingCamera:AVCaptureDevice?
    var currentDevice:AVCaptureDevice?
    
    var captureDeviceInput: AVCaptureDeviceInput?
    
    // configuring an output device
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    
    //Creating a Preview Layer and Start the Session
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cau hinh quan ly in out
        captureSesstion.sessionPreset = AVCaptureSessionPresetPhoto
        
        // get camera
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
        for device in devices {
            if device.position == .back {
                backFacingCamera = device
            } else if device.position == .front {
                frontFacingCamera = device
            }
        }
        currentDevice = backFacingCamera
        // get instance cua device
        do {
            captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
        } catch {
            print(error)
        }
        
        // Configure the session with the output for capturing still images
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        //Coordinating the Input and Output using Session
        // Configure the session with the input and the output devices
        captureSesstion.addInput(captureDeviceInput)
        captureSesstion.addOutput(stillImageOutput)
        
        //Creating a Preview Layer and Start the Session
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSesstion)
        view.layer.addSublayer(cameraPreviewLayer!)
        
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = view.frame
        
        view.bringSubview(toFront: cameraButton)
        captureSesstion.startRunning()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToCamera(_ segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func capture(_ sender: AnyObject) {
    }
    
}

    
