//
//  ViewController.swift
//  UICountDownTime
//
//  Created by Vu on 11/9/20.
//

import UIKit

class ViewController: UIViewController {

    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 120
    var endTime: Date?
    var timeLabel =  UILabel()
    var timeDetail = UILabel()
    var timer = Timer()
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        
            drawBgShape()
            drawTimeLeftShape()
            addTimeLabel()
            // here you define the fromValue, toValue and duration of your animation
            strokeIt.fromValue = 1
            strokeIt.toValue = 0
            strokeIt.duration = timeLeft
            // add the animation to your timeLeftShapeLayer
            timeLeftShapeLayer.add(strokeIt, forKey: nil)
            // define the future end time by adding the timeLeft to now Date()
            endTime = Date().addingTimeInterval(timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00:00"
            timer.invalidate()
        }
    }

    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 100), radius:
            100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.gray.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 5
        view.layer.addSublayer(bgShapeLayer)
    }
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 100), radius:
            100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.red.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 5
        view.layer.addSublayer(timeLeftShapeLayer)
    }
    
    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRect(x: view.frame.midX - 50 ,y: view.frame.midY-125, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        view.addSubview(timeLabel)
        timeDetail = UILabel(frame: CGRect(x: view.frame.minX ,y: view.frame.midY, width: view.frame.width, height: 50))
        timeDetail.textAlignment = .center
        timeDetail.text = "OTP sẽ hết hạn sau 2 phút"
        view.addSubview(timeDetail)
    }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

