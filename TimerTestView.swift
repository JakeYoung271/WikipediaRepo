import SwiftUI

struct newContentView: View {
    @State var timer: Timer?
    
    var body: some View {
        VStack (spacing: 55) {
            Button(action: {setupTimer()}) {
                Text("start")
            }
            Button(action: {resetTimer()}) {
                Text("reset")
            }
        }.frame(width: 333, height: 333)
        .onAppear {
           setupTimer()
        }
    }
    
    private func setupTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            // This code stop running when timer invalidate
            print("----> timer running")
        })
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
}


#Preview {
    newContentView()
}
