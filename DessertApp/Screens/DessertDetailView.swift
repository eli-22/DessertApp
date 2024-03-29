//
//  DessertDetailView.swift
//  DessertApp
//
//  Created by Elise on 4/16/23.
//

import SwiftUI

struct DessertDetailView: View {
    
    @ObservedObject var dessertDetailVM: DessertDetailViewModel
    
    var body: some View {
        ZStack {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    Text(dessertDetailVM.selectedDessert.mealName)
                        .foregroundColor(.accentColor)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    AsyncImage(url: URL(string: dessertDetailVM.selectedDessert.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    } placeholder: {
                        Image(systemName: "birthday.cake")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    }
                    
                    Text("Ingredients")
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.top, .bottom])
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(0..<dessertDetailVM.ingredientMeasurements.count, id:\.self) { index in
                        let array = dessertDetailVM.ingredientMeasurements
                        HStack {
                            Text("\(array[index].0): ")
                                .fontWeight(.medium)
                            Text(array[index].1)
                            Spacer()
                        }
                    }.padding(.bottom, 2)
                    
                    Text("Instructions")
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.top,.bottom])
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                    Text(dessertDetailVM.dessertDetail?.instructions ?? "No instructions provided.")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.bottom)
                }
                .padding()
                .task {
                    dessertDetailVM.getDessertDetails()
                }
            }
            if dessertDetailVM.isLoading {
                LoadingSpinner()
            }
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertDetailVM: DessertDetailViewModel(selectedDessert: MockData.mockDessert))
    }
}
