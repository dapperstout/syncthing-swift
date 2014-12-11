import pulse

class SocketSpy: GCDAsyncSocket {

    var readStreamRef: Unmanaged<CFReadStreamRef>? = nil
    var connectShouldSucceed = true

    var tlsStarted = false
    var disconnected = false

    var latestHost: String?
    var latestPort: UInt16?
    var latestTlsSettings: [NSObject:AnyObject]?
    var latestDelegate: GCDAsyncSocketDelegate?

    override func setDelegate(delegate: AnyObject?) {
        latestDelegate = delegate as? GCDAsyncSocketDelegate
    }

    override func connectToHost(host: String!, onPort port: UInt16, error errPtr: NSErrorPointer) -> Bool {
        latestHost = host
        latestPort = port
        return connectShouldSucceed
    }

    override func startTLS(tlsSettings: [NSObject:AnyObject]!) {
        tlsStarted = true;
        latestTlsSettings = tlsSettings
    }

    override func disconnect() {
        disconnected = true;
    }

    override func readStream() -> Unmanaged<CFReadStreamRef>! {
        return readStreamRef
    }
}