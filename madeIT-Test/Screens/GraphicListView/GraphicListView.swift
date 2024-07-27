

import SwiftUI
import SwiftData

struct GraphicListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var graphics: [Graphic]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(graphics) { graphic in
                    VStack(alignment: .leading) {
                        Text(graphic.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text(graphic.notes)
                        
                        if let imageData = graphic.image, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 250, maxHeight: .infinity)
                        }
                        
                    }
                    
                }
                .onDelete(perform: deleteGraphic)
            }
            .navigationTitle("🖼 Grafiken")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func deleteGraphic(at offsets: IndexSet) {
        for index in offsets {
            let graphic = graphics[index]
            modelContext.delete(graphic)
        }
    }
}
//
//#Preview {
//    GraphicListView()
//}
