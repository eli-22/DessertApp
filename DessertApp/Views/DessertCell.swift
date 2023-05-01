//
//  DessertCell.swift
//  DessertApp
//
//  Created by Elise on 4/16/23.
//

import SwiftUI

struct DessertCell: View {
    let dessert: Dessert
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: dessert.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
                    .cornerRadius(8)
            } placeholder: {
                Image(systemName: "birthday.cake")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
                    .cornerRadius(8)
            }
            Text(dessert.mealName)
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading, 10)
        }
    }
}

struct DessertCell_Previews: PreviewProvider {
    static var previews: some View {
        DessertCell(dessert: MockData.mockDessert)
    }
}
