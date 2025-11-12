
final class GhostBox<Value> {
  var value: Value
  init(value: Value) { self.value = value }
}

@propertyWrapper
struct GhostState<Value> {
  // 実体は heap に逃がす。
  private var box: GhostBox<Value>
  
  var wrappedValue: Value {
    get { box.value }
    // struct の配下で宣言されたプロパティの値を更新できるように nonmutating にする。
    nonmutating set { box.value = newValue }
  }
  
  // 他の struct が更新を掴めるようにする。
  var projectedValue: GhostBinding<Value> {
    GhostBinding(
      get: { self.box.value },
      set: { self.box.value = $0 }
    )
  }
  
  init(wrappedValue: Value) {
    self.box = GhostBox(value: wrappedValue)
  }
}

struct GhostBinding<Value> {
  private let getter: () -> Value
  private let setter: (Value) -> Void
  
  var wrappedValue: Value {
    get { getter() }
    nonmutating set { setter(newValue) }
  }
  
  init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
    self.getter = get
    self.setter = set
  }
}


