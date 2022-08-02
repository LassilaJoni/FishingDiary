//
//  ContentView.swift
//  FishingDiary
//
//  Created by Joni Lassila on 2.8.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY

    @State var title: String = ""
    @State private var showSheet: Bool = false
    
    @State var image : Data = .init(count: 0)
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) var viewContext

        @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    //: MARK - BODY

    var body: some View {
        NavigationView {
            VStack {
              
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: FishDetailView(item: item)) {
                            Image(uiImage: (UIImage(data: item.imageData ?? self.image) ?? UIImage(systemName: "photo"))!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 34, height: 210)
                                .cornerRadius(15)
                            HStack {
                                Text("\(item.details ?? "")")
                                
                            }//:HSTACK
                        }
                        // Insert timestamp here with .footnote font
                        }
                    }
                    //.onDelete(perform: deleteItems)
                    
                    if showSheet {
                        AddFishView()
                    }
                }//: LIST
                .navigationBarTitle("Fishes", displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.showSheet.toggle()
                })
                   {
                    Image(systemName: "camera.fill")
                })
                .sheet(isPresented: self.$showSheet) {
                    AddFishView()//.environment(\.managedObjectContext, self.viewContext)
                }
            } //: VSTACK
        } //: NAVIGATION
    }

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
