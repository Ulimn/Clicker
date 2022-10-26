import Foundation
import ArgumentParser

@main
struct Clicker: ParsableCommand {
    @Argument() var pid: Int!
    
    func run() {
        if (pid == nil) {
            print("PID argument not set. Exiting.");
            return;
        }
        
        print("Starting Clicker for process by PID", pid!)
        
        let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
        
        let keyCode: CGKeyCode = 0x71; // F15
        // let keyCode: CGKeyCode = 0x11; // T
        
        let key_down = CGEvent(keyboardEventSource: src, virtualKey: keyCode, keyDown: true)   // F15 down
        let key_up = CGEvent(keyboardEventSource: src, virtualKey: keyCode, keyDown: false)  // F15 up
        
        while (1==1) {
            key_down?.postToPid( pid_t(pid) ); // convert int to pid_t
            key_up?.postToPid( pid_t(pid) );
            let sleepSeconds: TimeInterval = Double.random(in: 2..<5) * 60
            Thread.sleep(forTimeInterval: sleepSeconds)
        }
        
    }
}
