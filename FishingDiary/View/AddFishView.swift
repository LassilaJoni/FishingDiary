//
//  AddFishView.swift
//  FishingDiary
//
//  Created by Joni Lassila on 2.8.2022.
//

import SwiftUI
import CoreData

struct AddFishView: View {
    // MARK - FUNCTION
    
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: self.viewContext)
            newItem.timestamp = Date()
            newItem.title = title
            newItem.details = details
            newItem.imageData = self.image

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showSheet = false
    
    @State private var title: String = ""
    @State private var details: String = ""
    
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        VStack {
            if self.image.count != 0 {
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    Image(uiImage: UIImage(data: self.image)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(6)
                }
            } else {
                Button(action: {
                    self.showSheet.toggle()
                }) {
                Image(systemName: "photo.fill")
                    .font(.system(size: 55))
                    .foregroundColor(.gray)
            }
            }
                TextField("Title", text: $title)
                    .padding()
                    .background(
                        Color(UIColor.systemGray6)
                    )
                    .cornerRadius(10)
            TextField("Description", text: $details)
                .padding()
                .background(
                    Color(UIColor.systemGray6)
                )
                .cornerRadius(10)
                
                Button(action: {
                    addItem()
                }, label: {
                    Spacer()
                    Text("SAVE")
                    Spacer()
                })
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.pink)
                .cornerRadius(10)
            }//: VSTACK
        .sheet(isPresented: self.$showSheet, content: {
            ImagePicker(show: self.$showSheet, image: self.$image)
        })
            .padding(.horizontal)
        .padding(.vertical, 20)
        
        }
    
    }

struct AddFishView_Previews: PreviewProvider {
    static var previews: some View {
        AddFishView()
    }
}
