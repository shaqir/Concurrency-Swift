import SwiftUI

actor TapCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    func value() -> Int {
        return count
    }
}

struct ContentView: View {
    @State private var counterValue = 0
    let counter = TapCounter()

    var body: some View {
        VStack(spacing: 20) {
            Text("Counter Value: \(counterValue)")
                .font(.largeTitle)
                .padding()

            Button("Tap Me") {
                Task {
                    await counter.increment()
                    counterValue = await counter.value()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())

            Button("Fetch Message") {
                Task {
                    let message = await fetchMessage()
                    print("Fetched: \(message)")
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }

    func fetchMessage() async -> String {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return "Hello from async world!"
    }
}

#Preview {
    ContentView()
}
