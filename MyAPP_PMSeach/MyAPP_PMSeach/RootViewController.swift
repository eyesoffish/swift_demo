//
//  RootViewController.swift
//  MyAPP_PMSeach
//
//  Created by fengei on 16/5/25.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import MapKit
class RootViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate{

    var mapView:MKMapView!
    var locateMange = CLLocationManager()
    var currentCoordInate:CLLocationCoordinate2D?//经纬度
    var city:String?;
    var gescoder = CLGeocoder()// 地图编码
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = city;
        Mylocation()
        let longGesture = UILongPressGestureRecognizer(target: self, action:#selector(RootViewController.longGestureClick(_:)))
        self.view.addGestureRecognizer(longGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Mylocation()
    {
        mapView = MKMapView()
        mapView.frame = self.view!.bounds
        mapView.mapType = MKMapType.Standard
        //跟随到当前位置
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsPointsOfInterest = true
        mapView.showsTraffic = true
        self.mapView.showsUserLocation = true//显示定位点
        self.view.addSubview(mapView)
        
        self.locateMange.delegate = self;
        self.locateMange.distanceFilter = 10.1
        
        //请求定位权限
        if self.locateMange.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization))
        {
            self.locateMange.requestAlwaysAuthorization()
        }
        self.locateMange.requestWhenInUseAuthorization()
        self.locateMange.desiredAccuracy = kCLLocationAccuracyBest//定位精准度
        self.locateMange.startUpdatingLocation()//开始定位
        print("正在准备定位")
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLoca = locations.last
        {
            CLGeocoder().reverseGeocodeLocation(newLoca, completionHandler: { (pms, err) in
                if let newCoordinate = pms?.last?.location?.coordinate
                {
                    self.mapView.setCenterCoordinate(newCoordinate, animated: true)
                    self.currentCoordInate = newCoordinate
                    //获取最后一个地标，注意一个地名可能搜索出多个地址
                    let placemark:CLPlacemark = (pms?.last!)!
                    let location = placemark.location//位置
                    let region = placemark.region//区域
                    let addressDic = placemark.addressDictionary//详细地址
                    let name=placemark.name;//地名
                    //let thoroughfare=placemark.thoroughfare;//街道
                    //let subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
                    //let locality=placemark.locality; // 城市
                    //let subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
                    //let administrativeArea=placemark.administrativeArea; // 州
                    //let subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
                    //let postalCode=placemark.postalCode; //邮编
                    //let ISOcountryCode=placemark.ISOcountryCode; //国家编码
                    //let country=placemark.country; //国家
                    //let inlandWater=placemark.inlandWater; //水源、湖泊
                    //let ocean=placemark.ocean; // 海洋
                    //let areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
                    self.city = placemark.locality//city
                    print(location,region,addressDic,name)
                }
            })
        }
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            self.locateMange.startUpdatingLocation()
        }
    }
//    public typealias CLGeocodeCompletionHandler = ([CLPlacemark]?, NSError?) -> Void／／block
    func regeoCoderWithLocation(location:CLLocation, callback:(mark:CLPlacemark)->Void)
    {
        gescoder.reverseGeocodeLocation(location) { (placeMarks, err) in
            let placeMark = placeMarks?.last
            callback(mark: placeMark!)// 回调
        }
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        //创建遮盖类型
        let lineRenderer = MKPolylineRenderer()
        lineRenderer.strokeColor = UIColor.yellowColor()
        lineRenderer.fillColor = UIColor.redColor()
        lineRenderer.lineWidth = 7
        return lineRenderer
    }
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        print(userLocation.location)
        let span = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
        let region = MKCoordinateRegionMake(userLocation.coordinate, span)
        self.mapView.setRegion(region, animated: true)
        
    }
    func longGestureClick(sender:UILongPressGestureRecognizer)
    {
        let point = sender.locationInView(sender.view)
        let tempCoordinate = self.mapView.convertPoint(point, toCoordinateFromView: sender.view)
        let location = CLLocation(latitude: tempCoordinate.latitude,longitude: tempCoordinate.longitude)
        self.regeoCoderWithLocation(location) { (mark) in
            let pointAnnotaion = MKPointAnnotation()
            pointAnnotaion.title = mark.name
            pointAnnotaion.subtitle = "快看这里"
            pointAnnotaion.coordinate = tempCoordinate
            self.mapView.addAnnotation(pointAnnotaion)
            //下面可疑开始导航了。
        }
    }
}
