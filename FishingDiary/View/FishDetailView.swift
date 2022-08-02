//
//  FishDetailView.swift
//  FishingDiary
//
//  Created by Joni Lassila on 2.8.2022.
//

import SwiftUI


struct FishDetailView: View {
    //@Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    //let item: Item
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        Text(item.title ?? "")
        Text(item.details ?? "")
        Image(uiImage: UIImage(data: item.imageData ?? self.image)!)
            .resizable()
            .frame(width: UIScreen.main.bounds.width - 34, height: 210)
            .cornerRadius(15)
    }
}

/*struct FishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FishDetailView(item: Item)
    }
}*/

