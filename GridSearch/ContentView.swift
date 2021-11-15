//
//  ContentView.swift
//  GridSearch
//
//  Created by Ivan Valero on 13/11/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @ObservedObject var gridViewModel = GridViewModel()
    @State var textValue = ""
    @State var visible = false
    
    var body: some View {
        NavigationView{
            VStack{
            // SearchBar
                SearchView(textValue: $textValue, visible: $visible)
            //
                VStack {
                    ScrollView{
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 50, maximum: 200), spacing: 12, alignment: .top),
                        GridItem(.flexible(minimum: 50, maximum: 200), spacing: 12, alignment: .top),
                        GridItem(.flexible(minimum: 50, maximum: 200), alignment: .top),
                    ], spacing: 22 ,content: {
                        ForEach((gridViewModel.results).filter({"\($0)".contains(textValue) || textValue.isEmpty}), id: \.self) { app in
                          
                            // Grid View
                            GridView(app: app)
                            //
                        }
                    })
                        .padding(.horizontal, 8)
                }
                    .navigationTitle("Grid Search")
                }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")

        }
    }
}

// MARK: -GridView

struct GridView: View {
    
    let app: Result
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 6) {
                
                KFImage(URL(string: app.artworkUrl100))
                    .cornerRadius(14)
                //                                Spacer()
                //                                    .frame(width: 100, height: 100, alignment: .center)
                //                                    .background(Color.red)
                Text(app.name)
                    .font(.system(size: 10, weight: .semibold))
                Text(app.releaseDate)
                    .font(.system(size: 8, weight: .regular))
                Text(app.artistName)
                    .font(.system(size: 8, weight: .regular))
                    .foregroundColor(Color(.systemGray))
                Spacer()
            }
            .padding(.horizontal, 4)
            //                            .background(Color(.systemCyan))
            
            Spacer()
        }
    }
}

// MARK: - SearchView

struct SearchView: View {
    
    @Binding var textValue: String
    @Binding var visible: Bool
    
    var body: some View {
        VStack{
            HStack {
                TextField("Search apps here", text: $textValue)
                    .padding(.horizontal, 28)
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .onTapGesture {
                        visible = true
                    }
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            if visible {
                                Button(action: {
                                    
                                    textValue = ""
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                })
                            }
                            
                        }
                            .foregroundColor(Color(.systemGray))
                            .padding(.horizontal, 10)
                    ).transition(.move(edge: .trailing))
                    .animation(.spring(), value: visible)
                
                HStack {
                    if visible {
                        Button(action: {
                            textValue = ""
                            visible = false
                            // Descactivar teclado
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Cancel")
                        })
                            .transition(.move(edge: .trailing))
                            .animation(.spring(), value: visible)
                    }
                    
                }
            }
        }.padding()
    }
}
