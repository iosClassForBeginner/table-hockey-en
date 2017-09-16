# table-hockey-en
A SpriteKit game app
# Code Together: Let's make iPhone app in an hour

<div style="text-align:center;margin-left:25%">
  <img src="https://github.com/iosClassForBeginner/table-hockey-en/blob/master/assets/game.PNG?raw=true" width="50%" height="50%"/>
</div>  

Thank you for visiting our account. We are going to make a map app in an hour. If would you like to study yourself before hands-on, or review what you have learned in the session, please use the following material.

## Meetup
We are providing free hands-on on a monthly basis

https://www.meetup.com/iOS-Development-Meetup-for-Beginner/

## Do you need a tutor?
We also hold face-to-face or group lesson for individual interested in making iOS app themselves

http://ios-class-for-beginner.esy.es/

## Development Environment
  Xcode 8.3.2 / Swift 3

# Full procedure
## 0, Create your project

> 0-1. Open Xcode
> 0-2. Select <sup>Create a new Xcode project</sup> or Go to <code>File</code> → <code>New</code> → <code>Project...</code>  
> 0-3. Select <sup>Game</sup> and then tap <sup>Next</sup>  
> 0-4. Fill <sup>Product name</sup>, select <sup>SpriteKit</sup> then click <sup>Next</sup>  
> 0-5. Select the place for saving your project and then tap <sup>Create</sup>  
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid1.gif?      raw=true" />    </div>
> </details>

## 1, Design your app
#### 🗂 Main.storyboard

> 2-1. Remove <code>helloLabel</code> from <code>GameScene.sks</code> file.
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid1.gif?      raw=true" />    </div>
> </details>
> 2-2. Set up the puck.
> <ul>
>   <li>Drag and drop a <code>Color Sprite</code> to your Scene.</li>
>   <li>Set its <code>Name</code> to "puck".</li>
>   <li>Fix its position to (0 , 0) and its width and height to 30.</li>
> </ul>
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid1.gif?      raw=true" />    </div>
> </details>
> 2-3. Add the <code>2x</code> puck and player images to your assets and 
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid2.gif?raw=true" /> >     </div>
> </details>
> 2-4. Set pucks <code>Texture</code> to "puck-2x" and lower the opacity for the Scene color for better appearance.
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid5.gif?raw=true" /> >     </div>
> </details>
> 2-5. Change the <code>Body Type</code> to "Bounding circle".
> <ul>
>   <li>Uncheck "Allows rotation"</li>
>   <li>Uncheck "Affected By Gravity"</li>
>   <li>Set "Friction" to 0</li>
>   <li>Set "Restitution" to 0</li>
>   <li>Set "Lin. Damping" to 0</li>
>   <li>Set "Ang. Damping" to 0</li>
>   <li>Set "Category Mask" to 2</li>
>   <li>Set "Collision Mask" to 1</li>
>   <li>Set "Field Mask" to 0</li>
>   <li>Set "Contact Mask" to 1</li>
> </ul>
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid5.gif?raw=true" /> >     </div>
> </details>

## 2, Connect UI components to the ViewController
#### 🗂 Main.storyboard → ViewController.swift  
  ★  control + drag in storyboard to create a control segue
  
> 3-1. Connect "MKMapView"
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center">
>     <img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid3.gif?raw=true" />
>   </div>
>  </details>

> 3-2. Connect "UISegmentControl"
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center">
>     <img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid4.gif?raw=true" />
>   </div>
> </details>


## 4, Add code blocks in ViewController.swift
#### 🗂 ViewController.swift  
> ★ It's preferable to write following code yourself. It will help you to understand code more.

```Swift  
import UIKit
import MapKit           // Import MapKit to use your MKMapViw
import CoreLocation     // Import CoreLocation to access GPS

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    var isCentered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()             // Required in order to access GPS coordinates
        
    }
    
    func centerMapOnLocation(coordinate: CLLocationCoordinate2D) {
    
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        self.map.setRegion(region, animated: true)
        
    }
    
    @IBAction func mapTypeChanged(sender: UISegmentedControl) {
    
        switch (sender.selectedSegmentIndex) {
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.hybrid
        case 2:
            map.mapType = MKMapType.satellite
        default: break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !isCentered {
            self.centerMapOnLocation(coordinate: locations.first!.coordinate)
            isCentered = true
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        default: 
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }
}
```
