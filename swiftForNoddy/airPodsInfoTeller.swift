import IOKit.ps

func fetchMacBatteryLevel() -> Int? {
    let info = IOPSCopyPowerSourcesInfo().takeRetainedValue()
    let sources: Array<CFTypeRef> = IOPSCopyPowerSourcesList(info).takeRetainedValue() as Array
    guard let source = sources.first,
          let description = IOPSGetPowerSourceDescription(info, source)?.takeUnretainedValue() as? [String: AnyObject],
          let level = description[kIOPSCurrentCapacityKey] as? Int else {
        return nil
    }
    return level
}