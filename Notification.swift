
import Foundation

extension NotificationCenter {
    func addObserverOnce(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) {
        
        weak var token: NSObjectProtocol?
        token = addObserver(forName: name, object: obj, queue: queue) {notification in
            
            token.map(self.removeObserver)
            block(notification)
        }
    }
}



override func viewDidAppear(_ animated: Bool) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InitAdScroll"), object: nil)
}




// Register notification way1
NotificationCenter.default.addObserverOnce(forName: NSNotification.Name(rawValue: "InitAdScroll"), object: nil, queue: OperationQueue.main) { (note) in
    self.initAdScroll()
}

// Register notification way2
var token: NSObjectProtocol!
token = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "InitAdScroll"),
                            object: nil,
                            queue: OperationQueue.main) { notification in
                            print("(　´･‿･｀): \(notification)")
                            NotificationCenter.default.removeObserver(token)
                            self.initAdScroll()
}

// Register notification way3
NotificationCenter.default.addObserver(self, selector: #selector(initAdScroll), name: NSNotification.Name(rawValue: "InitAdScroll"), object: nil)


@objc func initAdScroll() {

}