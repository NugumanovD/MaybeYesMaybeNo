import Foundation

var task: DispatchWorkItem?

task = DispatchWorkItem {
    while true {
        print("0")
        if task!.isCancelled {
            break
        }
    }
}

let concurrentQueue = DispatchQueue.global()

concurrentQueue.async(execute: task!)

concurrentQueue.asyncAfter(deadline: .now() + 2 ) {
    task?.cancel()
}

let queueDeadlock = DispatchQueue(label: "com.playground.queueDeadlock")
queueDeadlock.async {
    print("aSync quene is started")
    queueDeadlock.sync {
        print("sync is started")
    }
}
