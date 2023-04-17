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
                    }.padding()
                    
                    Text("Instructions")
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                    Text(dessertDetailVM.dessertDetail?.strInstructions ?? "No instructions provided.")
                        .padding(.bottom)
                    
                    Text("Ingredients")
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    HStack {
                        VStack {
                            ForEach(Array(dessertDetailVM.ingredientMeasurements.keys), id: \.self) { key in
                                HStack {
                                    Text(key)
                                    Spacer()
                                }
                                .padding(.bottom, 1)
                            }
                        }
                        VStack {
                            ForEach(Array(dessertDetailVM.ingredientMeasurements.keys), id: \.self) { key in
                                HStack {
                                    Text("\(dessertDetailVM.ingredientMeasurements[key] ?? "")")
                                    Spacer()
                                }
                                .padding(.bottom, 1)
                            }
                        }
                    }
                    
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
