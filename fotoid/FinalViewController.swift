//
//  FinalViewController.swift
//  fotoid
//
//  Created by Cassia Franco on 31/08/2019.
//  Copyright © 2019 Cassia Franco. All rights reserved.
//

import UIKit
import Photos

class FinalViewController: UIViewController {
    

    @IBOutlet weak var ivPhoto: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
        ivPhoto.layer.borderWidth = 10
        ivPhoto.layer.borderColor = UIColor.white.cgColor

    }
    
    func salveToAlbum (){
        PHPhotoLibrary.shared().performChanges({
            
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset] as NSArray)
            
        }) { (sucess, error) in
            if !sucess{
                print(error!.localizedDescription)
            }else{
                let alert = UIAlertController (title: "Imagem Salva!", message: "Sua imagem foi salva no álbum de fotos! ", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        
        }
        
    }

    @IBAction func save(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
                case .authorized:
                    self.salveToAlbum()
                default:
                    let alert = UIAlertController (title: "ERRO", message: "Você precisa autorizar o acesso ao álbum para poder salvar sua foto ", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
            }
            
        }
    
    }
    
    @IBAction func restart(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
