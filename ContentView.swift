import SwiftUI

struct ContentView: View {
  @GhostState private var count = 0
  
  var body: some View {
    VStack(spacing: 0) {
      Text("👻 Count: \(count)")
        .font(.title)
      
      Button("＋1") {
        count += 1
      }
      
      ChildView(counter: $count)
    }
  }
}

struct ChildView: View {
  var counter: GhostBinding<Int>
  
  var body: some View {
    VStack {
      Text("🧒 Child counter = \(counter.wrappedValue)")
      Button("＋5 (from child)") {
        counter.wrappedValue += 5
      }
    }
  }
}
