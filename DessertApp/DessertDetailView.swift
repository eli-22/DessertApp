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
                    Text(dessertDetailVM.dessertDetail?.strMeal ?? MockData.mockDessertDetail.strMeal)
                        .foregroundColor(.accentColor)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    AsyncImage(url: URL(string: dessertDetailVM.selectedDessert.strMealThumb)) { image in
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
                    
                    ForEach(dessertDetailVM.ingredientMeasurements, id:\.0) { tuple in
                        HStack {
                            Text("\(tuple.0): ")
                                .fontWeight(.medium)
                            Text(tuple.1)
                            Spacer()
                        }
                    }.padding(.bottom, 2)
                    
                    Text("Instructions")
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.top,.bottom])
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                    Text(dessertDetailVM.dessertDetail?.strInstructions ?? "No instructions provided.")
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
