import UIKit

var task: DispatchWorkItem?

task = DispatchWorkItem {
    while true {
        print("0")
        if (task!.isCancelled) {
            break;
        }
    }
}

let concurrentQueue = DispatchQueue.global()

concurrentQueue.async(execute: task!)

concurrentQueue.asyncAfter(deadline: .now() + 2 ) {
    task?.cancel()
}

