//
//  ReportRelaxationAndAttention.swift
//  EnterAffectiveCloudUI
//
//  Created by Enter on 2019/12/23.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

public class PrivateReportRelaxationAndAttention: UIView {
    
    public var largeValue = 100 {
        willSet {
            relaxationCircleView.largeValue = CGFloat(newValue)
            attentionCircleView.largeValue = CGFloat(newValue)
        }
    }
    
    public var smallValue = 0 {
        willSet {
            relaxationCircleView.smallValue = CGFloat(newValue)
            attentionCircleView.smallValue = CGFloat(newValue)
        }
    }

    public var relaxationValue:Int = 0 {
        willSet {
            relaxationNumberView.number = newValue
            relaxationCircleView.currentValue = CGFloat(newValue)
            for i in 0..<(relaxationStateArray.count-1) {
                let range = relaxationStateArray[i]...relaxationStateArray[i+1]
                if range.contains(newValue) {
                    switch i {
                    case 0:
                        relaxationNumberView.state = .low
                    case 1:
                        relaxationNumberView.state = .nor
                    case 2:
                        relaxationNumberView.state = .high
                    default:
                        relaxationNumberView.state = .high
                    }
                    break
                }
            }
        }
    }
    
    public var attentionValue:Int = 0 {
        willSet {
            attentionNumberView.number = newValue
            attentionCircleView.currentValue = CGFloat(newValue)
            for i in 0..<(attentionStateArray.count-1) {
                let range = attentionStateArray[i]...attentionStateArray[i+1]
                if range.contains(newValue) {
                    switch i {
                    case 0:
                        attentionNumberView.state = .low
                    case 1:
                        attentionNumberView.state = .nor
                    case 2:
                        attentionNumberView.state = .high
                    default:
                        attentionNumberView.state = .high
                    }
                    break
                }
            }
        }
    }
    
    public var relaxationColor = UIColor.colorWithHexString(hexColor: "5e75ff")
    public var attentionColor = UIColor.colorWithHexString(hexColor: "5fc695")
    
    private var relaxationStateArray = [0 ,60, 80, 100] //放松度等级分段
    
    private var attentionStateArray = [0 ,60, 80, 100] //注意力等级分段
    
    private var relaxationStateColor = UIColor.colorWithHexString(hexColor: "abb7ff")
    private var attentionStateColor = UIColor.colorWithHexString(hexColor: "c7ffe4")
    private var relaxationStateTextColor = UIColor.colorWithHexString(hexColor: "555b7f")
    private var attentionStateTextColor = UIColor.colorWithHexString(hexColor: "637f72")
    
    private let relaxationNumberView = PrivateReportNumberView()
    private let relaxationCircleView = PrivateReportSemiCircle()
    
    private let attentionNumberView = PrivateReportNumberView()
    private let attentionCircleView = PrivateReportSemiCircle()
    
    private let line = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initFunction()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        initFunction()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initFunction()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        line.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().offset(-8)
        }
        
        relaxationNumberView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalTo(line.snp.top).offset(-25)
        }
        
        relaxationCircleView.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(130)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(line.snp.top).offset(-25)
        }
        
        attentionNumberView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        attentionCircleView.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(130)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(230)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func initFunction() {
        self.backgroundColor = .clear
        self.addSubview(relaxationNumberView)
        self.addSubview(relaxationCircleView)
        self.addSubview(attentionNumberView)
        self.addSubview(attentionCircleView)
        self.addSubview(line)
        relaxationCircleView.shaperColor = relaxationColor
        relaxationCircleView.text = "Relaxation"
        attentionCircleView.shaperColor = attentionColor
        attentionCircleView.text = "Attention"
        
        relaxationNumberView.stateColor = relaxationStateColor
        relaxationNumberView.stateTextColor = relaxationStateTextColor
        
        attentionNumberView.stateColor = attentionStateColor
        attentionNumberView.stateTextColor = attentionStateTextColor
        
        line.backgroundColor = UIColor.colorWithHexString(hexColor: "f0f0f0")
        line.layer.cornerRadius = 1
    }
    
}
