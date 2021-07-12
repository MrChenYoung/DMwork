//
//  LocationController.swift
//  DMwork
//
//  Created by MrChen on 2021/6/19.
//  Copyright © 2021 MrChen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationController: UIViewController, CLLocationManagerDelegate {
    // 地图
    private var mapView: MKMapView?
    // 定位
    private var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 我的位置
        self.title = "我的位置"
        self.view.backgroundColor = UIColor.white
        
        // 添加地图
        self.addMapView()
        
        // 定位信息
        self.setupLocationManager()
    }
    
    // 添加地图
    func addMapView() {
        self.mapView = MKMapView.init(frame: self.view.bounds)
        self.view.addSubview(self.mapView!)
    }
    
    // 定位信息
    func setupLocationManager() {
        self.locationManager = CLLocationManager.init()
        self.locationManager?.delegate = self
        // 开始定位
        self.locationManager?.startUpdatingLocation()
    }
    
    // 定位到位置
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last ?? CLLocation.init()
        // 定位到的坐标点
        let coordinate: CLLocationCoordinate2D = location.coordinate
        
        // 添加大头针
        let annotation: MKPointAnnotation = MKPointAnnotation.init()
        annotation.coordinate = coordinate
        self.mapView?.addAnnotation(annotation)
        
        // 设置地图中心点
        self.mapView?.centerCoordinate = coordinate
        // 设置地图展示区域
        let latitudeDelta: CLLocationDegrees = CLLocationDegrees(self.mapView?.region.span.latitudeDelta ?? 0.0 * 0.5)
        let longitudeDelta: CLLocationDegrees = CLLocationDegrees(self.mapView?.region.span.longitudeDelta ?? 0.0 * 0.5)
        self.mapView?.setRegion(MKCoordinateRegion.init(center: coordinate, span: MKCoordinateSpan.init(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)), animated: true)
        
        // 停止定位
        self.locationManager?.stopUpdatingLocation()
    }

}
