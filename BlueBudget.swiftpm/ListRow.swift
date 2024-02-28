import SwiftUI

struct ListRow: View {
    
    let list: Listing
    
    var body: some View {
        HStack {
            Label {
                VStack(alignment: .leading, spacing: 5) {
                    Text(list.title)
                        .fontWeight(.medium)
                    
                    Text(list.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            } icon: {
                
            }
            
            if list.isComplete {
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.secondary)
                    .padding(.trailing, -6)
            }
            
        }
        .badge(list.remainingItemCount)
        .padding(.horizontal)

    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: Listing())
    }
}
