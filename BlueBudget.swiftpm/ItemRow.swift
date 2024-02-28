import SwiftUI
import AVFoundation

struct ItemRow: View {
    @Binding var item: Item
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @Binding var sound: Bool
    
    @State private var quantity: Double = 0.0
    @State private var price: Double = 0.0
    
    @ObservedObject var audioManager = AudioManager()
    
    var body: some View {
        HStack(spacing: 0) {
            withAnimation {
                Button {
                    item.isCompleted.toggle()
                    if item.isCompleted && sound {
                        audioManager.playTick()
                    }
                } label: {
                    Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                        .foregroundColor(item.isCompleted ? Color("Blue1") : Color("TextColor"))
                }
                .buttonStyle(.plain)
                .frame(width: 10, height: 10)
            }
            
            TextField("Item name...", text: $item.text, axis: .vertical)
                .opacity(item.isCompleted ? 0.4 : 1.0)
                .padding(.leading, 12)
            
            Spacer()
            
            TextField("QTY", value: $item.quantity, format: .number)
                .keyboardType(.numbersAndPunctuation)
                .foregroundColor(.secondary)
                .frame(width: 50, height: 30)
                .opacity(item.isCompleted ? 0.4 : 1.0)
            
            TextField("Price", value: $item.price, format: .number)
                .keyboardType(.numbersAndPunctuation)
                .foregroundColor(.secondary)
                .frame(width: 50, height: 30)
                .opacity(item.isCompleted ? 0.4 : 1.0)
            
            
        }
        .onAppear {
            quantity = item.quantity
            price = item.price
        }
        .onChange(of: quantity) { qty in
            item.quantity = qty
        }
        .onChange(of: price) { p in
            item.price = p
        }
        
        // for some reason, sometimes the decimal part doesn't work on the textfield, i got it to work on the simulator, I hope it work on your iPad too!
        
    }
}
