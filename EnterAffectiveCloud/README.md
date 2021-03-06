# Enter AffectiiveCloud iOS SDK

- [Enter AffectiiveCloud iOS SDK](#enter-affectiivecloud-ios-sdk)
  - [Demo](#demo)
  - [快速接入](#%e5%bf%ab%e9%80%9f%e6%8e%a5%e5%85%a5)
    - [对象初始化](#%e5%af%b9%e8%b1%a1%e5%88%9d%e5%a7%8b%e5%8c%96)
    - [服务订阅](#%e6%9c%8d%e5%8a%a1%e8%ae%a2%e9%98%85)
    - [获取报表](#%e8%8e%b7%e5%8f%96%e6%8a%a5%e8%a1%a8)
    - [实现代理方法](#%e5%ae%9e%e7%8e%b0%e4%bb%a3%e7%90%86%e6%96%b9%e6%b3%95)
    - [结束情感云](#%e7%bb%93%e6%9d%9f%e6%83%85%e6%84%9f%e4%ba%91)
  - [情感云API使用说明](#%e6%83%85%e6%84%9f%e4%ba%91api%e4%bd%bf%e7%94%a8%e8%af%b4%e6%98%8e)

## Demo

[心流 App](https://github.com/Entertech/Enter-AffectiveCloud-Demo-iOS.git) 这个演示应用集成了基础蓝牙功能、蓝牙设备管理界面、情感云SDK、以及自定义的数据展示控件，较好的展示了脑波及心率数据从 硬件中采集到上传情感云实时分析最后产生分析报表及数据展示的整个过程。

## 快速接入

> 只需要实例化 `AffectiveCloudClient` 类就可以请求情感云数据，通过代理 `AffectiveCloudResponseDelegate` 来获取情感云分析后的结果。

### 对象初始化

```swift
// AffectiveCloudClient对象创建
let client = AffectiveCloudClient(websocketURLString: yourURL, appKey: yourAppKey, appSecret: yourSecret, userID: yourLocalID)

```

| 参数               | 类型   | 说明                                  |
| ------------------ | ------ | ------------------------------------- |
| websocketURLString | String | 情感云websocket的url字符串            |
| appKey             | String | 情感云的appKey，向您的合作伙伴获取    |
| appSecret          | String | 情感云的appSecret，向您的合作伙伴获取 |
| userID             | String | 您本地App的id字段, 要保证唯一性， 请参考[id](https://docs.affectivecloud.com/%F0%9F%8E%99%E6%8E%A5%E5%8F%A3%E5%8D%8F%E8%AE%AE/3.%20%E4%BC%9A%E8%AF%9D%E5%8D%8F%E8%AE%AE.html#userID)                    |


### 服务订阅

```swift
// 请求生物信号数据
self.client.initBiodataServices(services: [.EEG, .HeartRate])

// 请求情感数据
self.client.startAffectiveDataServices(services: [.attention, .relaxation, .pleasure, .pressure])

// 订阅生物信号
self.client.subscribeBiodataServices(services: [.eeg_all, .hr_all])

// 订阅情感数据
self.client.subscribeAffectiveDataServices(services: [.attention, .relaxation, .pressure, .pleasure])
```

### 数据传输

```
// 原始脑电数据：硬件监听方法
func eegData() {
    ...
    self.client.appendBiodata(eegData: data)
}

// 心率数据： 硬件监听方法
func hrData() {
    ...
    self.client.appendBiodata(hrData: data)
}
```

### 获取报表

```swift
// 获取生物数据报表
self.client.getBiodataReport(services: [.EEG, .HeartRate])

// 获取情感数据报表
self.client.getAffectiveDataReport(services: [.relaxation, .attention, .pressure, .pleasure])

```

### 实现代理方法

```swift
self.client.affectiveCloudDelegate = self
```

继承`AffectiveCloudResponseDelegate`,并实现以下回调：

```swift
// 生物数据订阅
func biodataServicesSubscribe(client: AffectiveCloudClient, response: AffectiveCloudResponseJSONModel) {
    if response.code != 0 {
        return
    }
        
    if let data = response.dataModel as? CSBiodataProcessJSONModel {
        if let eeg = data.eeg {
        // eeg.waveLeft, eeg.waveRight, eeg.alpha..
        // 在此获取您需要的脑波数据
        }
        if let hr = data.hr {
        // 在此获取您需要的心率数据
        }
    }
}

// 生物数据报表
func biodataServicesReport(client: AffectiveCloudClient, response: AffectiveCloudResponseJSONModel) {
    if response.code != 0 {
        return
    }
    if let data = response.dataModel as? CSBiodataReportJsonModel {
        if let hr = data.hr {
          // hr, hrv等报表数据
        }
        if let eeg = data.eeg {
          // eeg相关报表数据
        }
    }
}

// 情感数据订阅
func affectiveDataSubscribe(client: AffectiveCloudClient, response: AffectiveCloudResponseJSONModel) {
    if response.code != 0 {
        return
    }
        
    if let data = response.dataModel as? CSAffectiveSubscribeProcessJsonModel {
        if let attention = data.attention?.attention {
            print("attention \(attention)")
        }
        if let relaxation = data.relaxation?.relaxation {

        }
        if let pressure = data.pressure?.pressure {

        }
    }
}

// 情感数据报表
func affectiveDataReport(client: AffectiveCloudClient, response: AffectiveCloudResponseJSONModel)  {
    guard response.code == 0 else {
        return
    }
    if let report = response.dataModel as? CSAffectiveReportJsonModel {
        if let attention = report.attention {
        // array, average
        }
        if let relaxation = report.relaxation {

        }
        if let pressure = report.pressure {
        }
    }
}
```

### 结束情感云

```swift
// 结束情感数据服务
self.client.close()

```

## 情感云API使用说明
- 情感云的API文档请查看：[情感云API文档](../APIDocuments/Enterr-AffectiveCloud-iOS-SDK-API说明.md)

