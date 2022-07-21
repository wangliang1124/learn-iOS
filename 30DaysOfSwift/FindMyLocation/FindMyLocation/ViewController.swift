//
//  ViewController.swift
//  FindMyLocation
//
//  Created by 王亮 on 2022/7/17.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationLabel: UILabel = {
        let label =  UILabel()
        label.text = "My Location"
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
        return label
    }()
    
    var findMyLocation: UIButton = {
        
        var configuration = UIButton.Configuration.gray() // 1
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.buttonSize = .large
        configuration.title = "Find My Location"
        
        let button  = UIButton(configuration: configuration)
//        button.setTitle("Find My Location", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        button.setBackgroundImage(UIImage(named: "Find my location"), for: .normal)
//        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 14
        button.addTarget(nil, action: #selector(myLocationButtonDidTouch), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
    }()
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let effectView =  UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = self.view.bounds
        

        if let image = UIImage(named: "bg") {
            view.backgroundColor = UIColor(patternImage: image)
        }
        
        
        view.addSubview(effectView)
        view.addSubview(locationLabel)
        view.addSubview(findMyLocation)
        
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            locationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            findMyLocation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            findMyLocation.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
//            findMyLocation.heightAnchor.constraint(equalToConstant: 78)
        ])
        
    }
    
    @objc func myLocationButtonDidTouch() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /* CLLocationManagerDelegate */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationLabel.text = "Error while updating location " + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!, completionHandler: {
            (placemarks, error) in
            guard error == nil else {
                self.locationLabel.text = "Reverse geocoder failed with error " + error!.localizedDescription
                return
            }
            
            if let placemark = placemarks?.first {
                self.displayLocationInfo(placemark: placemark)
                
            } else {
                self.locationLabel.text = "Problem with the data received from geocoder"
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        
        let locality = placemark.locality ?? ""
        let postalCode = placemark.postalCode ?? ""
        let administrativeArea = placemark.administrativeArea ?? ""
        let country = placemark.country ?? ""
        
        
        var location = postalCode + " " + locality
        location.append("\n")
        location.append(administrativeArea + " " + country)
        
        self.locationLabel.text = location
    }
}

