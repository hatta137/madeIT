

import SwiftUI
import SwiftData

struct AttachmentListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var attachments: [Attachment]
    @Query var customers: [Customer]
    
    @State private var selectedFilter: FilterType = .alphabetical
    
    enum FilterType {
        case alphabetical
        case byCustomer
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Sortieren nach", selection: $selectedFilter) {
                        Text("Alphabetisch").tag(FilterType.alphabetical)
                        Text("Kunde").tag(FilterType.byCustomer)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                if filteredAndSortedAttachments.isEmpty {
                    Text("Keine Anhänge verfügbar")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(filteredAndSortedAttachments) { attachment in
                            NavigationLink(destination: AttachmentDetailView(attachment: attachment)) {
                                VStack(alignment: .leading) {
                                    Text(attachment.name)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Text(attachment.notes)
                                    
                                    Text(attachment.customer?.name ?? "Kunde nicht gefunden")
                                }
                            }
                        }
                        .onDelete(perform: deleteAttachment)
                    }
                }
            }
            .navigationTitle("📑 Anhänge")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var filteredAndSortedAttachments: [Attachment] {
        // Sortieren nach ausgewähltem Filter
        switch selectedFilter {
        case .alphabetical:
            return attachments.sorted { $0.name < $1.name }
        case .byCustomer:
            return attachments.sorted { ($0.customer?.name ?? "") < ($1.customer?.name ?? "") }
        }
    }
    
    func deleteAttachment(at offsets: IndexSet) {
        for index in offsets {
            let attachment = attachments[index]
            modelContext.delete(attachment)
        }
    }
}
//
//#Preview {
//    GraphicListView()
//}
