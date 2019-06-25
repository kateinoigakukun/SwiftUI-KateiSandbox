
struct Text: View {
    
    let value: String
    
    typealias Body = Never
    var body: Never { fatalError() }
}

struct CounterView: View {
    @State var counter: Int
    var body: some View {
        Text(value: counter.description)
    }
}
