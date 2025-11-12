

@propertyWrapper
struct Ghost<Value> {
  private var value: Value
  
  var wrappedValue: Value {
    get { value }
    set { value = newValue }
  }
  
  var projectedValue: Ghost<Value> { self }
  
  init(wrappedValue: Value) {
    self.value = wrappedValue
  }
}

struct GhostTests {
  @Ghost var message = "I'm a ghost!"
}

let ghostTests = GhostTests()
print(ghostTests.message)
print(ghostTests.$message)

