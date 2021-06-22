//
//  CameraView.swift
//  pruebaNatch
//
//  Created by Angel Olvera on 22/06/21.
//

import UIKit
import AVFoundation
import Firebase

class CameraView: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backcamera : AVCaptureDevice?
    var frontCamera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    var photoOutput : AVCapturePhotoOutput?
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                backcamera = device
            }
            else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        currentCamera = frontCamera
    }
    
    func setupInputOutput(){
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }catch{
            print(error)
        }
    }
    
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
        
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
}

extension CameraView: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            image = UIImage(data: imageData)
            print("imagen tomada ", image!)
            let subirImagen = self.redimensionarImagen(image: self.image!, targetSize: CGSize(width: 100.0, height: 100.0))
            self.guardarImagen(imagen: subirImagen)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func redimensionarImagen(image: UIImage, targetSize: CGSize) -> UIImage{
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heigthRatio = targetSize.height / size.height
        var newSize : CGSize
        if widthRatio > heigthRatio {
            newSize = CGSize(width: size.width * heigthRatio, height: size.height * heigthRatio)
        }
        else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func guardarImagen(imagen : UIImage){
//        let ref = Database.database().reference()
//        let storage = Storage.storage().reference()
//        guard let nombreImagen = Auth.auth().currentUser?.uid else { return }
//        let directorio = storage.child("imagenesAsistencia/\(nombreImagen)")
//        directorio.delete { error in
//            if error != nil {
//                print("error al borrar")
//            }
//            else{
//                print("se borro correctamente")
//            }
//        }
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/png"
//        directorio.putData(imagen.pngData()!, metadata: metadata){ (data, error) in
//            if error == nil{
//                print("se guardo la imagen")
//            }
//            else {
//                if let error = error?.localizedDescription{
//                    print("error al cargar imagen", error)
//                }
//                else {
//                    print("error de codigo")
//                }
//            }
//        }
//        ref.child("Asistencia/ID/\(nombreImagen)/Storage").setValue(String(describing: directorio))
    }
}
