//
//  ViewController.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import QuartzCore

class ShuttleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var busStop:BusStop!
    var selectedShuttle:Shuttle?
    var shuttles = [Shuttle]()
    
    fileprivate let reuseIdentifier = "ShuttleCollectionViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    fileprivate let itemsPerRow: CGFloat = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ShuttleBusAPI.GetShuttleStop(bustStop: busStop.name!, completion: {
            [unowned self] (shuttleServiceListAPI)  in
            if let shuttles = shuttleServiceListAPI?.shuttleServiceResult?.shuttles {
                self.shuttles = shuttles
                self.collectionView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UICollectionViewDelegate
extension ShuttleViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        
        selectedShuttle = shuttles[indexPath.row];
        performSegue(withIdentifier: "MapViewController", sender: self);
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "MapViewController"
        {
            let controller = segue.destination as! MapViewController
            controller.shuttle = selectedShuttle
        }
        
    }

 
}

// MARK: - UICollectionViewDataSource
extension ShuttleViewController: UICollectionViewDataSource {
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return shuttles.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! ShuttleCollectionViewCell
        
        let shuttle = shuttles[indexPath.row]
        cell.thumbnail.image = UIImage(named: "bus")
        cell.thumbnail.layer.cornerRadius = 5
        cell.rightArrow.image = UIImage(named: "right_arrow")
        cell.title.text = shuttle.name
        cell.arrival.text = "Arrival: " + shuttle.arrivalTime!
        cell.nextArrival.text = "Next Arrival: " + shuttle.nextArrivalTime!
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShuttleViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 110)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
