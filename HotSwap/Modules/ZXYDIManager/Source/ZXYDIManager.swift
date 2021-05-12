import Swinject
import ZXYModuleProtocols

public final class ZXYDIManager {
  static public var shared: ZXYDIManager?
  public let container: Container
  
  public init(parentContainer: Container?) {
    container = Container(parent: parentContainer)
  }
  
  deinit {
    container.removeAll()
  }
}

@propertyWrapper
public struct Injected<Service> {
  private var service: Service?
  public init() {
    service = ZXYDIManager.shared?.container.resolve(Service.self)
  }
  public init(name: String? = nil, container: Resolver? = nil) {
    if let container = container {
      service = container.resolve(Service.self, name: name)
    } else {
      service = ZXYDIManager.shared?.container.resolve(Service.self, name: name)
    }
  }
  public var wrappedValue: Service? {
    mutating get {
      service
    }
    mutating set { service = newValue  }
  }
  public var projectedValue: Injected<Service> {
    get { return self }
    mutating set { self = newValue }
  }
}

//public protocol AutoRegister {
//  static func autoRegister()
//}
