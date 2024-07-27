import SwiftUI
import SwiftData

struct NewResourceView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedTextField: FormTextField?
    
    @State private var name = ""
    @State private var typeOfRessource: TypeOfResource = .undefined
    @State private var notes = ""
    @State private var ip = ""
    @State private var url = ""
    @State private var userName = ""
    @State private var password = ""
    @State private var customer: Customer? = nil
    
    @State private var isSaved = false
    
    @Query var customers: [Customer]
    
    enum FormTextField {
        case name, notes, ip, url, userName, password
    }
    
    var body: some View {
        NavigationStack {
            Form {
                customerInformationSection
                deviceInformationSection
                networkInformationSection
                accessInformationSection
                saveButton
            }
        }
    }
    
    private var customerInformationSection: some View {
        Section("Kundeninformation") {
            Picker("Kunde", selection: $customer) {
                Text("Wähle einen Kunden").tag(Customer?.none)
                ForEach(customers, id: \.self) { customer in
                    Text(customer.name).tag(customer as Customer?)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    private var deviceInformationSection: some View {
        Section("Geräteinformationen") {
            TextField("Name", text: $name)
                .focused($focusedTextField, equals: .name)
                .onSubmit { focusedTextField = .notes }
                .submitLabel(.next)
            
            TextField("Notiz", text: $notes)
                .focused($focusedTextField, equals: .notes)
                .onSubmit { focusedTextField = .ip }
                .submitLabel(.next)
            
            Picker("Typ", selection: $typeOfRessource) {
                ForEach(TypeOfResource.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    private var networkInformationSection: some View {
        Section("Netzwerkinformationen") {
            TextField("IP-Adresse", text: $ip)
                .focused($focusedTextField, equals: .ip)
                .onSubmit { focusedTextField = .url }
                .submitLabel(.next)
            
            TextField("URL", text: $url)
                .focused($focusedTextField, equals: .url)
                .onSubmit { focusedTextField = .userName }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .submitLabel(.next)
        }
    }
    
    private var accessInformationSection: some View {
        Section("Zugangsinformationen") {
            TextField("Username", text: $userName)
                .focused($focusedTextField, equals: .userName)
                .onSubmit { focusedTextField = .password }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .submitLabel(.next)
            
            TextField("Password", text: $password)
                .focused($focusedTextField, equals: .password)
                .onSubmit { focusedTextField = nil }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .submitLabel(.continue)
        }
    }
    
    private var saveButton: some View {
        Button("Save Changes") {
            let newRessource = Resource(
                name: name,
                typeOfRessource: typeOfRessource,
                notes: notes,
                ip: ip,
                url: url,
                customer: customer,
                userName: userName,
                password: password
            )
            
            modelContext.insert(newRessource)
            
            resetForm()
            
            isSaved = true
            dismiss()
        }
    }
    
    private func resetForm() {
        name = ""
        typeOfRessource = .undefined
        notes = ""
        ip = ""
        url = ""
        userName = ""
        password = ""
        customer = nil
    }
}
