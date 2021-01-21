//
//  ContentView.swift
//  CountriesFlagsAndCodes
//
//  Created by Stewart Lynch on 2020-04-23.
//  Copyright © 2020 Stewart Lynch. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var countryVM:CountryViewModel = CountryViewModel()
    @State private var appStoreOnly = 0
    var body: some View {
    let filteredCountries = appStoreOnly == 1 ? countryVM.countries.filter {$0.appStore} : countryVM.countries
       return NavigationView {
                VStack {
                    HStack {
                        Picker(selection: $appStoreOnly, label: Text("")) {
                            Text("All Countries").tag(0)
                            Text("On App Store").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }.padding()
                    Text("\(filteredCountries.count) countries.")
                    List() {
                        ForEach(filteredCountries.sorted {$0.name < $1.name}) { country in
                            HStack {
                                Text("\(country.flag)").font(.largeTitle)
                                VStack(alignment: .leading) {
                                    Text("\(country.name)").font(.title)
                                    Text("\(country.code)").font(.caption)
                                    
                                }
                                Spacer()
                                if country.appStore {
                                    Image("AppStore")
                                    .resizable()
                                        .foregroundColor(Color(UIColor.systemBlue))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        
                    }
                    
            }
            .navigationBarTitle("Countries")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .colorScheme(.dark)
}
}
